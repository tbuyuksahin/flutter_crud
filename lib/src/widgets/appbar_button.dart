import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final IconData icon;

  const AppBarButton({
    this.icon,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text ?? "", style: TextStyle(color: Colors.amber)),
          SizedBox(width: 5),
          Icon(icon, color: Colors.amber),
        ],
      ),
    );
  }
}
