import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ljk2/components/upload_file.dart';

class HasilWithUploadScreen extends StatefulWidget {
  const HasilWithUploadScreen({Key? key}) : super(key: key);

  @override
  State<HasilWithUploadScreen> createState() => _HasilWithUploadScreenState();
}

class _HasilWithUploadScreenState extends State<HasilWithUploadScreen> {
  List<Map<String, dynamic>> uploadedFiles = [];

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (_) => UploadKunciJawabanPopup(
        onFilePicked: (fileData) {
          setState(() {
            uploadedFiles.add(fileData); // simpan file di list
          });
        },
      ),
    );
  }

  Widget buildFileGrid() {
    if (uploadedFiles.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada file yang diupload',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: uploadedFiles.length,
      itemBuilder: (context, index) {
        final file = uploadedFiles[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[100],
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Center(
            child: Text(
              file["fileName"] ?? "Unknown",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildFileGrid(), // Ganti Column jadi Grid
          ),

          // Tombol tambah di kanan bawah
          Positioned(
            bottom: 24,
            right: 24,
            child: GestureDetector(
              onTap: _showUploadDialog,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'assets/menuapp/tambah.svg',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
