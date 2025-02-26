import 'package:flutter/material.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final String albumName;
  final bool backupEnabled;

  const AlbumDetailsScreen({
    Key? key,
    required this.albumName,
    required this.backupEnabled,
  }) : super(key: key);

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  late bool _isBackupEnabled;

  @override
  void initState() {
    super.initState();
    _isBackupEnabled = widget.backupEnabled;
  }

  @override
  Widget build(BuildContext context) {
    // Mock list of photos and videos
    final List<String> mediaItems = List.generate(
        20, (index) => 'Media ${index + 1}'); // Replace with actual media data

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.albumName),
        actions: [
          Row(
            children: [
              Switch(
                value: _isBackupEnabled,
                onChanged: (value) {
                  setState(() {
                    _isBackupEnabled = value;
                  });
                },
                activeColor: Colors.red, // Red color for ON state
                inactiveThumbColor: Colors.white, // White button for OFF state
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce size
              ),
              const Text(
                'Backup',
                style: TextStyle(fontSize: 14), // Smaller text size
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: mediaItems.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[200],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  mediaItems[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    _isBackupEnabled ? Icons.check : Icons.close, // Updated icons
                    color: _isBackupEnabled ? Colors.green : Colors.red,
                    size: 20, // Adjusted icon size
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
