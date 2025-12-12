import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SvgPicture.asset(
        'assets/iconfitur/user-profile.svg',
        width: 30,
        height: 30,
        fit: BoxFit.cover,
      ),
    );
  }
}
