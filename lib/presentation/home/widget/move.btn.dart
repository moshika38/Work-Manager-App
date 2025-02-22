import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';

class MoveBtn extends StatelessWidget {
  final int totalTask;
  final int activeTask;
  final VoidCallback next;
  final VoidCallback prev;
  const MoveBtn({
    super.key,
    required this.next,
    required this.prev,
    required this.totalTask,
    required this.activeTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: prev,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: AppColors.white,
            ),
          ),
          Text(
            "${activeTask+1} / $totalTask",
            style: AppFontStyle.primaryBody.copyWith(
              color: AppColors.white,
            ),
          ),
          IconButton(
            onPressed: next,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 25,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
