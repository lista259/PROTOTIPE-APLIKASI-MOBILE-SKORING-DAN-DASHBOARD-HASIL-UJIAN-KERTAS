import 'package:flutter/material.dart';

Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Delete Confirmation",
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      final scale = Curves.easeOut.transform(anim1.value);
      return Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: anim1.value,
          child: AlertDialog(
            title: const Text("Delete Photo?"),
            content: const Text("Are you sure you want to delete this photo?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(true),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 18,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF27255),
                  minimumSize: const Size(136, 30),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
