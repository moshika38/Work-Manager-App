import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';

class AddBtn extends StatelessWidget {
  final VoidCallback onTap;
  const AddBtn({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.primaryBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.primaryBgColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Add",
                style: AppFontStyle.primaryBody.copyWith(
                  color: AppColors.primaryBgColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
