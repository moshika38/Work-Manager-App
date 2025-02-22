import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/providers/task.provider.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';

class MarkAsDoneDragBtn extends StatefulWidget {
  final String taskId;
  const MarkAsDoneDragBtn({
    super.key,
    required this.taskId,
  });

  @override
  State<MarkAsDoneDragBtn> createState() => _MarkAsDoneDragBtnState();
}

class _MarkAsDoneDragBtnState extends State<MarkAsDoneDragBtn> {
  double _dragPosition = 0.0;
  final double _maxDragDistance = 190.0;

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Container
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.secondaryBlue,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: !isDone
                ? Row(
                    children: [
                      const SizedBox(width: 60), // Space for Draggable button
                      Text(
                        "Mark as done",
                        style: AppFontStyle.primaryBody.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.white.withOpacity(0.5),
                        size: 15,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.white.withOpacity(0.7),
                        size: 15,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.white,
                        size: 15,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.library_add_check_sharp,
                        color: AppColors.white.withOpacity(0.5),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Done",
                        style: AppFontStyle.primaryBody.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        // Draggable Button
        !isDone
            ? Positioned(
                left: _dragPosition,
                child: Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) => GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _dragPosition += details.delta.dx;
                        _dragPosition =
                            _dragPosition.clamp(0.0, _maxDragDistance);
                      });
                    },
                    onHorizontalDragEnd: (details) async {
                      if (_dragPosition >= _maxDragDistance - 20) {
                        // Task marked as done
                        setState(() {
                          _dragPosition = _maxDragDistance;
                          isDone = true;
                        });
                        final del =
                            await taskProvider.deleteTask(widget.taskId);
                        if (del) {
                          isDone = false;
                          _dragPosition = 0.0;
                          setState(() {});
                        }
                      } else {
                        setState(() {
                          _dragPosition = 0.0;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.primaryBlue,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
