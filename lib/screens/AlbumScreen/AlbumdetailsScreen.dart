import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

class UploadController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> _getUserId() async {
    final user = _auth.currentUser;
    return user?.uid;
  }

  Future<void> uploadMedia(
      AssetEntity asset, int total, int index, Function(double) onProgress, Function(String) onComplete) async {
    final userId = await _getUserId();
    if (userId == null) return;

    final file = await asset.originFile;
    if (file == null) return;
    
    final bytes = await file.readAsBytes();
    final hash = sha256.convert(bytes).toString();
    final fileSize = file.lengthSync();
    final fileName = path.basename(file.path);
    final creationDate = (await asset.createDateTime).toIso8601String();
    final storagePath = "$userId/\${DateTime.now().millisecondsSinceEpoch}_$fileName";

    final existingFiles = await _firestore
        .collection("uploads")
        .where("hash", isEqualTo: hash)
        .where("size", isEqualTo: fileSize)
        .get();

    if (existingFiles.docs.isNotEmpty) {
      print("File already exists. Skipping upload.");
      onComplete(asset.id);
      return;
    }

    UploadTask uploadTask = _storage.ref(storagePath).putData(bytes);
    uploadTask.snapshotEvents.listen((event) {
      double progress = (event.bytesTransferred / event.totalBytes) * 100;
      onProgress(progress);
    });

    await uploadTask;
    await _firestore.collection("uploads").add({
      "userId": userId,
      "fileName": fileName,
      "path": storagePath,
      "hash": hash,
      "size": fileSize,
      "creationDate": creationDate,
    });

    onComplete(asset.id);
  }
}

class AlbumDetailScreen extends StatefulWidget {
  final AssetPathEntity album;

  const AlbumDetailScreen({Key? key, required this.album}) : super(key: key);

  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  bool uploadEnabled = false;
  final UploadController _uploadController = UploadController();
  final Map<String, double> uploadProgress = {};
  final Set<String> uploadedMedia = {};

  Future<List<AssetEntity>> _fetchAssets() async {
    final assetCount = await widget.album.assetCountAsync;
    return await widget.album.getAssetListRange(start: 0, end: assetCount);
  }

  Future<Uint8List?> _getThumbnail(AssetEntity asset) async {
    final size = ThumbnailSize(200, 200);
    return await asset.thumbnailDataWithSize(size);
  }

  Future<void> _uploadAllMedia() async {
    final media = await _fetchAssets();
    for (int i = 0; i < media.length; i++) {
      _uploadController.uploadMedia(media[i], media.length, i, (progress) {
        setState(() {
          uploadProgress[media[i].id] = progress;
        });
      }, (assetId) {
        setState(() {
          uploadedMedia.add(assetId);
          uploadProgress.remove(assetId);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.name),
        actions: [
          Switch(
            value: uploadEnabled,
            onChanged: (value) async {
              setState(() => uploadEnabled = value);
              if (value) {
                _uploadAllMedia();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<AssetEntity>>(
        future: _fetchAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No media found in this album.'));
          }

          final media = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: media.length,
            itemBuilder: (context, index) {
              final asset = media[index];
              return FutureBuilder<Uint8List?>(
                future: _getThumbnail(asset),
                builder: (context, thumbSnapshot) {
                  if (thumbSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (thumbSnapshot.hasError || thumbSnapshot.data == null) {
                    return const Icon(Icons.error);
                  } else {
                    return Stack(
                      children: [
                        Image.memory(
                          thumbSnapshot.data!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        if (uploadProgress.containsKey(asset.id))
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: CircularProgressIndicator(
                              value: uploadProgress[asset.id]! / 100,
                              strokeWidth: 2,
                            ),
                          ),
                        if (uploadedMedia.contains(asset.id))
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Icon(Icons.check_circle, color: Colors.green, size: 20),
                          ),
                      ],
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
