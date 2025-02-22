import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/presentation/home/widget/drag.btn.dart';
import 'package:task_manager/presentation/home/widget/move.btn.dart';
import 'package:task_manager/presentation/task/widgets/add.task.dart';

class TaskCard extends StatefulWidget {
  final int totalTask;
  final int activeTask;
  final String title;
  final String date;
  final String taskId;
  final VoidCallback nextTap;
  final VoidCallback prevTap;
  final bool isEmpty;

  const TaskCard({
    super.key,
    required this.totalTask,
    required this.activeTask,
    required this.title,
    required this.date,
    required this.taskId,
    required this.nextTap,
    required this.prevTap,
    required this.isEmpty,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.primaryBlue,
      ),
      child: !widget.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.secondaryBlue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.date,
                              style: AppFontStyle.primarySubHeadline
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(
                          widget.title,
                          style: AppFontStyle.primaryHeadline.copyWith(
                            color: AppColors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // animated drag button
                            MarkAsDoneDragBtn(
                            taskId: widget.taskId,
                          ),

                          // edit button
                          _buildTaskEditBtn(
                            () {
                              CreateNewTask(
                                date: widget.date,
                                title: widget.title,
                                taskId: widget.taskId,
                              ).showAddTaskDialog(context);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // move button
                      MoveBtn(
                        totalTask: widget.totalTask,
                        activeTask: widget.activeTask,
                        next: widget.nextTap,
                        prev: widget.prevTap,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.asset('assets/img/empty.png',
                    width: 200, height: 200),
              ),
            ),
    );
  }

  Widget _buildTaskEditBtn(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.white,
        ),
        child: Center(
          child: Icon(
            Icons.edit_document,
            size: 25,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
