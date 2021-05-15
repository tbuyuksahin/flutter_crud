import 'package:flutter/material.dart';

import 'colors.dart';

abstract class BaseStyles {
  //List user card target size

  //List user card target size
  static double get userImageContainerSize => 160.0;
  //List userCardPaddingSize
  static double get userCardPaddingSize => 5.0;
  static double get borderRadius => 25.0;
  static double get iconSize => 25.0;
  static double get borderWidth => 2.0;
  static double get listFieldHorizontal => 25.0;
  static double get listFieldVertical => 8.0;
  static double get animationOffset => 2.0;

  //List User Card Padding
  static EdgeInsets get userCardPadding {
    return EdgeInsets.all(userCardPaddingSize);
  }

  //List User Card Image Padding
  static EdgeInsets get userCardImagePadding {
    return EdgeInsets.only(right: 10.0, bottom: 10.0, top: 10.0);
  }

  static EdgeInsets get listPadding {
    return EdgeInsets.symmetric(
        horizontal: listFieldHorizontal, vertical: listFieldVertical);
  }

  static List<BoxShadow> get boxShadow {
    return [
      BoxShadow(
        color: AppColors.darkgray.withOpacity(.5),
        offset: Offset(1.0, 2.0),
        blurRadius: 2.0,
      ),
    ];
  }

  static List<BoxShadow> get boxShadowPressed {
    return [
      BoxShadow(
        color: AppColors.darkgray.withOpacity(.5),
        offset: Offset(1.0, 1.0),
        blurRadius: 1.0,
      )
    ];
  }

  static Widget iconPrefix(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(icon, size: 25.0, color: AppColors.lightblue),
    );
  }
}
