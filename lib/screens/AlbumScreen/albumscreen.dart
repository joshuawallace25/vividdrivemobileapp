import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vividdrive/screens/AlbumScreen/AlbumdetailsScreen.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  Future<String> _getUserLastName() async {
    // Get the current user's UID
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        // Get the full name and extract the last name
        String fullName = userDoc['fullName'] ?? '';
        List<String> nameParts = fullName.split(' ');
        if (nameParts.length > 1) {
          return nameParts.last; // Return the last name
        }
      }
    }
    return ''; // Return empty if no data found
  }

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
      appBar: AppBar(
        title: const Text('Album Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              // Sign out the user when logout button is pressed
              await FirebaseAuth.instance.signOut();
              Get.offAllNamed('/login'); // Navigate back to the login screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: _getUserLastName(), // Fetch the last name from Firestore
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading until data is fetched
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Display the user's last name
                  return Text(
                    'Hello, ${snapshot.data}! 😊',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
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
                        color:
                            album['backupEnabled'] ? Colors.green : Colors.red,
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
