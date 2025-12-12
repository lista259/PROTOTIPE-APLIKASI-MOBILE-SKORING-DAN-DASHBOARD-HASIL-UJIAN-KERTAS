import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<String?> showCameraOptionPopup(BuildContext context) {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.lightBlue,
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context), // close dialog tanpa return value
                child: SvgPicture.asset(
                  'assets/iconfitur/arrowleft.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          // select mau kamera atau galeri
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(context, 'Take Photo', 'assets/iconfitur/takephoto.svg', 'camera'),
              _buildOption(context, 'Photo Library', 'assets/iconfitur/photolibrary.svg', 'gallery'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildOption(BuildContext context, String label, String icon, String returnVal) {
  return GestureDetector(
    onTap: () => Navigator.pop(context, returnVal),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 48),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}