import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: SvgPicture.asset(
        'assets/menuapp/tambah.svg',
        width: 28,
        height: 28,
      ),
    );
  }
}
