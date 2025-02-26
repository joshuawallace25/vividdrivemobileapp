
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:vividdrive/screens/AlbumScreen/albumscreen.dart';


// ignore: must_be_immutable
class Navbar extends StatefulWidget {
  const Navbar({
    Key? key,
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List Screens = [AlbumScreen()];
    int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.blue[800],
        bottomNavigationBar: CurvedNavigationBar(
          index: _selectedIndex,
          color: Colors.blue,
          backgroundColor: Colors.white,
          items: [
            const Icon(Icons.home_filled, color: Colors.white),
             const Icon(Icons.album_outlined, color: Colors.white),
          ],
           animationDuration: const Duration(milliseconds: 300), 
          onTap: (index) {
            setState(() {
             _selectedIndex  = index;
            });
          },
          
        ),
        body: Screens[_selectedIndex],
    );
  }
}