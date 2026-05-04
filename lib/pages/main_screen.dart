import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:itc_directory/pages/favorite_screen.dart';
import 'package:itc_directory/pages/home_screen.dart';
import 'package:itc_directory/pages/structure_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    StructureScreen(),
    FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: SalomonBottomBar(
        margin: EdgeInsets.fromLTRB(50, 10, 50, 30),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          // Home
          SalomonBottomBarItem(
            icon: Icon(IconsaxPlusLinear.home_1, color: Colors.grey),
            activeIcon: Icon(IconsaxPlusBold.home_1, color: Color(0xFF153D21)),
            title: Text("Beranda"),
            selectedColor: Color(0xFF153D21),
          ),

          // Structure Organization
          SalomonBottomBarItem(
            icon: Icon(IconsaxPlusLinear.people, color: Colors.grey),
            activeIcon: Icon(IconsaxPlusBold.people, color: Color(0xFF153D21)),
            title: Text("Struktur"),
            selectedColor: Color(0xFF153D21),
          ),

          // Favorite
          SalomonBottomBarItem(
            icon: Icon(IconsaxPlusLinear.folder_favorite, color: Colors.grey),
            activeIcon: Icon(
              IconsaxPlusBold.folder_favorite,
              color: Color(0xFF153D21),
            ),
            title: Text("Favorite"),
            selectedColor: Color(0xFF153D21),
          ),
        ],
      ),
    );
  }
}
