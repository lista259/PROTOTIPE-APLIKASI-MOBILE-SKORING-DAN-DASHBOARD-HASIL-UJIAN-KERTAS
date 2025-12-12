import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ljk2/components/delete_actions.dart';

class CategoryConstants {
  static const matematika = 'Matematika';
  static const ipas = 'IPAS';
  static const pkn = 'PKN';
  static const bahasaIndonesia = 'Bahasa Indonesia';
  static const pjok = 'PJOK';
  static const seni = 'Seni';
  static const agama = 'Agama';
  static const bahasaInggris = 'Bahasa Inggris';
  static const bahasaDaerah = 'Bahasa Daerah';

  static const allCategories = [
    matematika,
    ipas,
    pkn,
    bahasaIndonesia,
    pjok,
    seni,
    agama,
    bahasaInggris,
    bahasaDaerah,
  ];

  static const categoryIcons = {
    matematika: 'assets/category/matematika.svg',
    ipas: 'assets/category/ipas.svg',
    pkn: 'assets/category/pkn.svg',
    bahasaIndonesia: 'assets/category/bahasa_indonesia.svg',
    pjok: 'assets/category/pjok.svg',
    seni: 'assets/category/seni.svg',
    agama: 'assets/category/agama.svg',
    bahasaInggris: 'assets/category/bahasa_inggris.svg',
    bahasaDaerah: 'assets/category/bahasa_daerah.svg',
  };
}

class ItemsTab extends StatefulWidget {
  final List<Map<String, dynamic>> savedItems;
  final Function(List<Map<String, dynamic>>) onItemsChanged;

  const ItemsTab({
    super.key,
    required this.savedItems,
    required this.onItemsChanged,
  });

  @override
  State<ItemsTab> createState() => _ItemsTabState();
}

class _ItemsTabState extends State<ItemsTab> {
  String selectedCategory = CategoryConstants.matematika;

  List<Map<String, dynamic>> get filteredItems {
    return widget.savedItems
        .where((item) => item['category'] == selectedCategory)
        .toList();
  }

  Widget buildCategoryIcons() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: CategoryConstants.allCategories.length,
        itemBuilder: (context, index) {
          final category = CategoryConstants.allCategories[index];
          final isSelected = selectedCategory == category;
          final iconPath = CategoryConstants.categoryIcons[category]!;

          return GestureDetector(
            onTap: () => setState(() => selectedCategory = category),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      iconPath,
                      width: 36,
                      height: 36,
                      colorFilter: isSelected
                          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                          : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.black : Colors.black54,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onImageTap(int index) async {
    final selectedImage = filteredItems[index];

    final shouldDelete = await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      barrierDismissible: true,
      pageBuilder: (_, __, ___) => _ZoomDeletePhotoOverlay(
        imageFile: File(selectedImage['image'].path),
        onDelete: () => Navigator.of(context).pop(true),
      ),
      transitionDuration: const Duration(milliseconds: 300),
    ));

    if (shouldDelete == true) {
      final updatedItems = List<Map<String, dynamic>>.from(widget.savedItems);
      updatedItems.remove(selectedImage);
      widget.onItemsChanged(updatedItems);
    }
  }

  Widget buildImageGrid() {
    final items = filteredItems;
    if (items.isEmpty) {
      return const Center(child: Text('Klik kamera untuk memindai lembar jawaban ulangan.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final img = items[index];
        return GestureDetector(
          onTap: () => _onImageTap(index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(img['image'].path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Kategori',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        buildCategoryIcons(),
        const SizedBox(height: 8),
        Expanded(child: buildImageGrid()),
      ],
    );
  }
}

class _ZoomDeletePhotoOverlay extends StatelessWidget {
  final File imageFile;
  final VoidCallback onDelete;

  const _ZoomDeletePhotoOverlay({
    Key? key,
    required this.imageFile,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(false),
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Hero(
                  tag: imageFile.path,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(imageFile),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    showDeleteConfirmationDialog(context).then((confirmed) {
                      if (confirmed == true) {
                        onDelete();
                      }
                    });
                  },
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
