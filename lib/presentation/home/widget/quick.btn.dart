import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';

class QuickBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isActive;
  const QuickBtn(
      {super.key, required this.text, this.onTap, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 12),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isActive ? AppColors.primaryBlue : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                text,
                style: AppFontStyle.primaryBody.copyWith(
                  color: isActive ? AppColors.white : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
