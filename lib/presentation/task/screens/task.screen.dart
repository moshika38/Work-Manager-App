import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/components/bottom.app.bar.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/data/models/task.model.dart';
import 'package:task_manager/core/providers/task.provider.dart';
import 'package:task_manager/presentation/task/widgets/add.task.dart';
import 'package:task_manager/presentation/task/widgets/delete.window.dart';
import 'package:task_manager/presentation/task/widgets/display.task.card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int todayTask = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBgColor,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'My Tasks',
            style: AppFontStyle.primarySubHeadline,
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {
                  CreateNewTask().showAddTaskDialog(context);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: AppColors.primaryBlue,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
        body: Consumer<TaskProvider>(
          builder: (context, taskScreenProvider, child) => FutureBuilder(
            future: taskScreenProvider.getAllTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final task = snapshot.data as List<TaskModel>;
                if (task.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'No Task Available',
                          style: AppFontStyle.primaryBody,
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/img/empty.png',
                          width: 200,
                          height: 200,
                        ),
                      ],
                    ),
                  );
                }

                todayTask = task
                    .where((element) =>
                        element.dueDate ==
                        DateTime.now().toString().split(' ')[0])
                    .length;

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Today\'s Tasks',
                                style: AppFontStyle.primarySubHeadline,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${DateTime.now().day} ${_getMonth(DateTime.now())}',
                                style: AppFontStyle.secondaryBody,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$todayTask Tasks',
                              style: AppFontStyle.primaryBody.copyWith(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              DeleteWindow.deleteTask(
                                context,
                                () {
                                  // delete task logic
                                  taskScreenProvider.deleteTask(task[index].id);
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: DisplayTaskCard(
                              title: task[index].title,
                              dueDate: task[index].dueDate,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryBlue,
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: const AppBottomAppBar(
          isActiveNumber: 2,
        ),
      ),
    );
  }

  String _getMonth(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[date.month - 1];
  }
}
