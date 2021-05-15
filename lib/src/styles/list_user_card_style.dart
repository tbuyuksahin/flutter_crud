import 'package:flutter/material.dart';
import 'base.dart';

abstract class UserCardStyle {
  static BoxDecoration get userCardDecoration {
    return BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: BaseStyles.borderWidth,
        ),
        color: Colors.black,
        borderRadius: BorderRadius.circular(BaseStyles.borderRadius));
  }
}
