import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/core/providers/task.provider.dart';

class CreateNewTask {
  final String? title;
  final String? date;
  final String? taskId;

  CreateNewTask({
    this.title,
    this.date,
    this.taskId,
  });

  Future showAddTaskDialog(BuildContext context) {
    DateTime? selectedDate;

    TextEditingController taskNameController =
        TextEditingController(text: title ?? '');
    final formKey = GlobalKey<FormState>();
    selectedDate = date != null ? DateTime.parse(date.toString()) : null;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create New Task',
                        style: AppFontStyle.primarySubHeadline,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: taskNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.primaryBgColor,
                          hintText: 'Task Name',
                          hintStyle: AppFontStyle.secondaryBody,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a task name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                text: selectedDate != null
                                    ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                    : "",
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.primaryBgColor,
                                hintText: 'Due Date',
                                hintStyle: AppFontStyle.secondaryBody,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today,
                                      size: 20),
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        selectedDate = picked;
                                      });
                                    }
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (selectedDate == null) {
                                  return 'Please select a due date';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: AppFontStyle.primaryBody.copyWith(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Consumer<TaskProvider>(
                            builder: (context, provider, child) =>
                                ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pop(context);

                                  taskId == null
                                      ? provider.createNewTask(
                                          taskNameController.text,
                                          selectedDate!
                                              .toString()
                                              .split(' ')[0],
                                        )
                                      : provider.updateTask(
                                          taskId!,
                                          taskNameController.text,
                                          selectedDate!
                                              .toString()
                                              .split(' ')[0],
                                        );
                                  taskNameController.text = '';
                                  selectedDate = null;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Create Task',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
