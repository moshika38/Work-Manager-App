import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SecondaryButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Get Started',
          style: AppFontStyle.primarySubHeadline.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }
}
