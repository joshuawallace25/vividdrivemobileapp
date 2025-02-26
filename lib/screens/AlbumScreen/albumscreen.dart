import 'package:flutter/material.dart';
import 'package:vividdrive/screens/AlbumScreen/AlbumdetailsScreen.dart';

class AlbumScreen extends StatelessWidget {


  const AlbumScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Static list of album categories with backup status
    final List<Map<String, dynamic>> albumCategories = [
      {'name': 'Screenshots', 'backupEnabled': true},
      {'name': 'Camera', 'backupEnabled': true},
      {'name': 'Videos', 'backupEnabled': false},
      {'name': 'WhatsApp', 'backupEnabled': true},
      {'name': 'Downloads', 'backupEnabled': false},
      {'name': 'Favorites', 'backupEnabled': true},
    ];

    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, John! 😊',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your Albums:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: albumCategories.length,
                itemBuilder: (context, index) {
                  final album = albumCategories[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.folder,
                        color: Colors.blue.shade700,
                      ),
                      title: Text(album['name']),
                      trailing: Icon(
                        album['backupEnabled']
                            ? Icons.cloud_done
                            : Icons.cloud_off,
                        color: album['backupEnabled']
                            ? Colors.green
                            : Colors.red,
                      ),
                      onTap: () {
                        // Navigate to album details screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlbumDetailsScreen(
                              albumName: album['name'],
                              backupEnabled: album['backupEnabled'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
