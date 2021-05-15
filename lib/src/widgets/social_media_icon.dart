import 'package:flutter/material.dart';

class AppSocialMediaWidget extends StatelessWidget {
  final String socialMedia;
  final IconData icon;
  final Color iconColor;
  final TextStyle style;

  const AppSocialMediaWidget({
    this.icon,
    this.iconColor,
    this.style,
    this.socialMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(child: Icon(icon, color: iconColor, size: 18)),
        SizedBox(width: 5),
        Text(socialMedia, style: style),
      ],
    );
  }
}
