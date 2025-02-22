import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/font.style.dart';

class DeleteWindow {
  static void deleteTask(BuildContext context, VoidCallback deleteLogic) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.red.withOpacity(0.1),
                  child: const Icon(Icons.delete, color: Colors.red, size: 32),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Delete Task',
                  style: AppFontStyle.primarySubHeadline,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Are you sure you want to delete this task?',
                  style: AppFontStyle.secondaryBody,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            _actionButton(
              false,
              () {
                Navigator.of(context).pop();
              },
            ),
            // delete button
            _actionButton(
              true,
               deleteLogic,
            ),
          ],
        );
      },
    );
  }

  static Widget _actionButton(bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          !isActive ? 'No, Keep It' : 'Yes, Delete',
          style: AppFontStyle.primaryBody.copyWith(
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}