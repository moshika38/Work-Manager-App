import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/providers/schedule.provider.dart';
import 'package:task_manager/core/services/schedule.notification.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/data/models/schedule.model.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  int monthIndex = DateTime.now().month - 1;
  int year = DateTime.now().year;

  final List<String> months = [
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

  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.primaryBgColor,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Column(
          children: [
            _buildMonthPicker(),
            const SizedBox(height: 20),
            _buildWeekDaysRow(),
            _buildCalender(),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthPicker() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondaryBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
            onPressed: () {
              setState(() {
                if (monthIndex == 0) {
                  monthIndex = 11;
                  year--;
                } else {
                  monthIndex--;
                }
              });
            },
          ),
          Text(
            '${months[monthIndex]} $year',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.white,
            ),
            onPressed: () {
              setState(() {
                if (monthIndex == 11) {
                  monthIndex = 0;
                  year++;
                } else {
                  monthIndex++;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDaysRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays
          .map((day) => Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    day,
                    style: AppFontStyle.primaryBody.copyWith(
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalender() {
    return Consumer<ScheduleProvider>(
      builder: (context, scheduleProvider, child) => FutureBuilder(
        future: scheduleProvider.getSchedulesByMonth(
          DateTime(year, monthIndex + 1),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listOfSchedule = snapshot.data as List<ScheduleModel>;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: DateTime(year, monthIndex + 2, 0).day,
              itemBuilder: (context, dayIndex) {
                bool isScheduled = listOfSchedule.any((schedule) {
                  DateTime scheduleDate = DateTime.parse(schedule.date);
                  return scheduleDate.day == dayIndex + 1 &&
                      scheduleDate.month == monthIndex + 1 &&
                      scheduleDate.year == year;
                });

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                            'Schedule for ${dayIndex + 1} ${months[monthIndex]} $year'),
                        content: SizedBox(
                          width: 300,
                          // height: 200,
                          child: FutureBuilder(
                            future: scheduleProvider.getSchedulesByCurrentDate(
                                '$year-${(monthIndex + 1).toString().padLeft(2, '0')}-${(dayIndex + 1).toString().padLeft(2, '0')}'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final currentDaySchedule =
                                    snapshot.data as List<ScheduleModel>;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: currentDaySchedule.length,
                                  itemBuilder: (context, index) {
                                    return _buildPopupWindowBody(
                                      currentDaySchedule,
                                      index,
                                      scheduleProvider,
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                      color: isScheduled ? AppColors.primaryBlue : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        '${dayIndex + 1}',
                        style: TextStyle(
                          fontSize: 16,
                          color: isScheduled ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildPopupWindowBody(
    List<ScheduleModel> currentDaySchedule,
    int index,
    ScheduleProvider scheduleProvider,
  ) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name : ${currentDaySchedule[index].title}",
              style: AppFontStyle.primaryBody),
          Text("Frequency : ${currentDaySchedule[index].frequency}",
              style: AppFontStyle.secondaryBody),
          Text("Date : ${currentDaySchedule[index].date}",
              style: AppFontStyle.secondaryBody),
          Text(
              "Time : ${currentDaySchedule[index].time.hour}:${currentDaySchedule[index].time.minute}",
              style: AppFontStyle.secondaryBody),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              // delete record from firebase
              scheduleProvider.deleteSchedule(currentDaySchedule[index].id);
              // delete scheduled notification
              ScheduleNotification.cancelNotification(
                  currentDaySchedule[index].scheduleId);
              Navigator.pop(context);

              // show snack bar 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${currentDaySchedule[index].title} is deleted'),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red.shade300,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                child: Text(
                  "Delete",
                  style: AppFontStyle.primaryBody.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
        ],
      )),
    );
  }
}
