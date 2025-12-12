import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadKunciJawabanPopup extends StatefulWidget {
  final void Function(Map<String, dynamic>) onFilePicked;

  const UploadKunciJawabanPopup({
    Key? key,
    required this.onFilePicked,
  }) : super(key: key);

  @override
  State<UploadKunciJawabanPopup> createState() => _UploadKunciJawabanPopupState();
}

class _UploadKunciJawabanPopupState extends State<UploadKunciJawabanPopup> {
  String? fileName;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'], // hanya XLSX
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          fileName = result.files.single.name;
        });

        final path = result.files.single.path;
        debugPrint("File dipilih: $path");

        // langsung kirim ke parent biar masuk ke list
        widget.onFilePicked({
          "fileName": fileName,
          "path": path,
          "category": "Matematika", // default kategori, bisa diubah sesuai kebutuhan
        });

        // tutup popup
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error saat pilih file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFEDF7FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Upload Kunci Jawaban",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.upload_file, size: 48, color: Colors.black),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4BA0E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                "Pilih file dari perangkat",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Format: XLSX"),
            if (fileName != null) ...[
              const SizedBox(height: 8),
              Text(
                "File dipilih: $fileName",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
