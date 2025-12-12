import 'dart:io';
import 'package:flutter/material.dart';
import 'ljk.dart';
import 'kunciljk.dart';
import 'package:ljk2/widgets/profile_avatar.dart';

class HasilScreen extends StatefulWidget {
  final List<Map<String, dynamic>> initialImages;
  final Function(List<Map<String, dynamic>>) onItemsChanged;

  const HasilScreen({
    Key? key,
    required this.initialImages,
    required this.onItemsChanged,
  }) : super(key: key);

  @override
  State<HasilScreen> createState() => _HasilScreenState();
}

class _HasilScreenState extends State<HasilScreen> {
  late List<Map<String, dynamic>> images;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    images = List.from(widget.initialImages);
  }

  void _updateImages(List<Map<String, dynamic>> updatedImages) {
    setState(() {
      images = updatedImages;
    });
    widget.onItemsChanged(images);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = [
      ItemsTab(
        savedItems: images,
        onItemsChanged: _updateImages,
      ),
      const HasilWithUploadScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Judul + profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Hasil',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    child: ProfileAvatar(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Tab menu (LJK dan Kunci LJK)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 0),
                    child: Center(
                      child: Text(
                        "LJK",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: _selectedIndex == 0
                              ? FontWeight.bold
                              : FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 1),
                    child: Center(
                      child: Text(
                        "Kunci LJK",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: _selectedIndex == 1
                              ? FontWeight.bold
                              : FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // garis abu + hitam
            Stack(
              children: [
                Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
                AnimatedAlign(
                  alignment: _selectedIndex == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 2,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Konten tab
            Expanded(
              child: _tabs[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
