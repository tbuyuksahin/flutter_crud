import 'package:flutter/material.dart';
import 'base.dart';

abstract class AppBarStyles {
  static OutlineInputBorder get appBarDecorationRight {
    return OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(BaseStyles.borderRadius)));
  }

  static OutlineInputBorder get appBarDecorationLeft {
    return OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(BaseStyles.borderRadius)));
  }
}
