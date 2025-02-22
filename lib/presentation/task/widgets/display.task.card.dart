import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';

class DisplayTaskCard extends StatelessWidget {
  final String title;
  final String dueDate;
  const DisplayTaskCard({
    super.key,
    required this.title,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title:   Text(
          title,
          style: AppFontStyle.primaryBody,
        ),
        subtitle:   Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Due date : $dueDate ',
            style: AppFontStyle.secondaryBody,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.check_circle,
              color: AppColors.primaryBlue,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
