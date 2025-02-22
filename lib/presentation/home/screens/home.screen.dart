import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/components/bottom.app.bar.dart';
import 'package:task_manager/components/end.drawer.dart';
import 'package:task_manager/components/notification.dart';
import 'package:task_manager/core/navigation/navigation.dart';
import 'package:task_manager/core/providers/task.provider.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/data/models/task.model.dart';
import 'package:task_manager/presentation/home/services/home.screen.services.dart';
import 'package:task_manager/presentation/home/widget/add.btn.dart';
import 'package:task_manager/presentation/home/widget/calender.view.dart';
import 'package:task_manager/presentation/home/widget/left.header.dart';
import 'package:task_manager/presentation/home/widget/quick.btn.dart';
import 'package:task_manager/presentation/home/widget/task.card.dart';
import 'package:task_manager/presentation/task/widgets/add.task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeTask = 0;
  int _activeTab = 0;
  String _dueDate = 'all';

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      HomeScreenServices().createUserIfNotExists(
        FirebaseAuth.instance.currentUser!.uid,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const AppBottomAppBar(
          isActiveNumber: 0,
        ),
        endDrawer: const EndDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AddBtn(
                      onTap: () {
                        // add new task
                        CreateNewTask().showAddTaskDialog(context);
                      },
                    ),
                    Builder(
                      builder: (BuildContext innerContext) {
                        return LeftHeader(
                          pressAvatar: () {
                            Scaffold.of(innerContext).openEndDrawer();
                          },
                          pressNotification: () {
                            AppNavigation.push(
                                context, const NotificationScreen());
                          },
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi ${FirebaseAuth.instance.currentUser!.displayName != null ? FirebaseAuth.instance.currentUser!.displayName!.split(' ')[0] : ""},",
                                style: AppFontStyle.primaryHeadline
                                    .copyWith(fontSize: 30),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Nice to see you !",
                                style: AppFontStyle.secondaryHeadline
                                    .copyWith(fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                        Consumer<TaskProvider>(
                          builder: (context, taskProvider, child) => Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    FutureBuilder(
                                        future: taskProvider.getAllTaskCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return QuickBtn(
                                              onTap: () {
                                                setState(() {
                                                  _activeTab = 0;
                                                  _dueDate = 'all';
                                                });
                                              },
                                              text: "All (${snapshot.data})",
                                              isActive: _activeTab == 0,
                                            );
                                          } else {
                                            return const QuickBtn(
                                              text: "All (0)",
                                              isActive: true,
                                            );
                                          }
                                        }),
                                    FutureBuilder(
                                        future:
                                            taskProvider.getTodayTaskCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return QuickBtn(
                                              onTap: () {
                                                setState(() {
                                                  _activeTab = 1;
                                                  _dueDate = 'today';
                                                });
                                              },
                                              text: "Today (${snapshot.data})",
                                              isActive: _activeTab == 1,
                                            );
                                          } else {
                                            return const QuickBtn(
                                              text: "Today (0)",
                                              isActive: false,
                                            );
                                          }
                                        }),
                                    FutureBuilder(
                                        future:
                                            taskProvider.getMonthTaskCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return QuickBtn(
                                              onTap: () {
                                                setState(() {
                                                  _activeTab = 2;
                                                  _dueDate = 'month';
                                                });
                                              },
                                              text:
                                                  "This Month (${snapshot.data})",
                                              isActive: _activeTab == 2,
                                            );
                                          } else {
                                            return const QuickBtn(
                                              text: "This Month (0)",
                                              isActive: false,
                                            );
                                          }
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              // display tasks

                              FutureBuilder(
                                future:
                                    taskProvider.filterTaskByDueDate(_dueDate),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final task =
                                        snapshot.data as List<TaskModel>;
                                    return task.isNotEmpty
                                        ? TaskCard(
                                            isEmpty: false,
                                            taskId: task[_activeTask].id,
                                            totalTask: task.length,
                                            activeTask: _activeTask,
                                            title: task[_activeTask].title,
                                            date: task[_activeTask].dueDate,
                                            nextTap: () {
                                              // go to next task
                                              _activeTask != task.length - 1
                                                  ? setState(() {
                                                      _activeTask++;
                                                    })
                                                  : setState(() {
                                                      _activeTask = 0;
                                                    });
                                            },
                                            prevTap: () {
                                              // back to previous task
                                              _activeTask != 0
                                                  ? setState(() {
                                                      _activeTask--;
                                                    })
                                                  : setState(() {
                                                      _activeTask =
                                                          task.length - 1;
                                                    });
                                            },
                                          )
                                        : TaskCard(
                                            taskId: '',
                                            totalTask: 0,
                                            activeTask: 0,
                                            title: 'No task have today  ',
                                            date: ' ',
                                            nextTap: () {},
                                            prevTap: () {},
                                            isEmpty: true,
                                          );
                                  }
                                  return TaskCard(
                                    taskId: '',
                                    totalTask: 0,
                                    activeTask: 0,
                                    title: ' ',
                                    date: ' ',
                                    nextTap: () {},
                                    prevTap: () {},
                                    isEmpty: true,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Calendar View",
                                    style: AppFontStyle.primarySubHeadline,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const CalenderView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
