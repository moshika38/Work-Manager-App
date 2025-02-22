import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/font.style.dart';

class FeaturePoint extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeaturePoint({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 26,
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: AppFontStyle.primarySubHeadline.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}