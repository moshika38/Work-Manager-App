import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';

class AppFontStyle {
  // heading
  static const TextStyle primaryHeadline = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryTextColor,
  );
  static const TextStyle secondaryHeadline = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryTextColor,
  );

  // sub-heading
  static const TextStyle primarySubHeadline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor,
  );
  static const TextStyle secondarySubHeadline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryTextColor,
  );

  // body
  static const TextStyle primaryBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryTextColor,
  );
  static const TextStyle secondaryBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryTextColor,
  );
}
