import 'package:flutter/material.dart';
import 'package:task_manager/core/navigation/navigation.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/presentation/home/screens/home.screen.dart';
import 'package:task_manager/presentation/schedule/screens/schedule.screen.dart';
import 'package:task_manager/presentation/task/screens/task.screen.dart';

class AppBottomAppBar extends StatefulWidget {
  final int isActiveNumber;
  const AppBottomAppBar({super.key, required this.isActiveNumber});

  @override
  State<AppBottomAppBar> createState() => _AppBottomAppBarState();
}

class _AppBottomAppBarState extends State<AppBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBottomAppBarBtn(Icons.home_outlined, "Home",
                  widget.isActiveNumber == 0 ? true : false, () {
                AppNavigation.pushReplacement(
                  context,
                  const HomeScreen(),
                );
              }),
              _buildBottomAppBarBtn(Icons.schedule_outlined, "Schedule",
                  widget.isActiveNumber == 1 ? true : false, () {
                AppNavigation.pushReplacement(
                  context,
                  const ScheduleScreen(),
                );
              }),
              _buildBottomAppBarBtn(Icons.task_alt_outlined, "Task",
                  widget.isActiveNumber == 2 ? true : false, () {
                AppNavigation.pushReplacement(
                  context,
                  const TaskScreen(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAppBarBtn(
    IconData icon,
    String text,
    bool isActive,
    VoidCallback? onTap,
  ) {
    return isActive
        ? Container(
            // width: 100,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.secondaryBgColor.withOpacity(0.4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Colors.grey[800],
                      size: 30,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      text,
                      style: AppFontStyle.primaryBody,
                    )
                  ],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: Icon(
              icon,
              color: Colors.grey[600],
              size: 30,
            ),
          );
  }
}
