import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/components/bottom.app.bar.dart';
import 'package:task_manager/core/providers/schedule.provider.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:uuid/uuid.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final TextEditingController _scheduleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedFrequency = 'Once';

  final uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBgColor,
        bottomNavigationBar: const AppBottomAppBar(
          isActiveNumber: 1,
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('New Schedule',
              style: AppFontStyle.primarySubHeadline),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text('Schedule Name',
                            style: AppFontStyle.primarySubHeadline),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _scheduleController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Enter schedule name',
                            hintStyle: AppFontStyle.secondaryBody,
                            filled: true,
                            fillColor: AppColors.primaryBgColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a schedule name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
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
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                            );

                            if (picked != null) {
                              setState(() => selectedDate = picked);
                            }
                          },
                          leading: const Icon(Icons.calendar_today,
                              color: AppColors.primaryBlue),
                          title: const Text('Date',
                              style: AppFontStyle.primaryBody),
                          subtitle: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: AppFontStyle.secondaryBody,
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (picked != null) {
                              setState(() => selectedTime = picked);
                            }
                          },
                          leading: const Icon(Icons.access_time,
                              color: AppColors.primaryBlue),
                          title: const Text('Time',
                              style: AppFontStyle.primaryBody),
                          subtitle: Text(
                            selectedTime.format(context),
                            style: AppFontStyle.secondaryBody,
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () async {
                            final String? frequency =
                                await showModalBottomSheet<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('Once'),
                                      onTap: () =>
                                          Navigator.pop(context, 'Once'),
                                    ),
                                    ListTile(
                                      title: const Text('Daily'),
                                      onTap: () =>
                                          Navigator.pop(context, 'Daily'),
                                    ),
                                    // ListTile(
                                    //   title: const Text('Weekly'),
                                    //   onTap: () =>
                                    //       Navigator.pop(context, 'Weekly'),
                                    // ),
                                    ListTile(
                                      title: const Text('Monthly'),
                                      onTap: () =>
                                          Navigator.pop(context, 'Monthly'),
                                    ),
                                    ListTile(
                                      title: const Text('Yearly'),
                                      onTap: () =>
                                          Navigator.pop(context, 'Yearly'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (frequency != null) {
                              setState(() => selectedFrequency = frequency);
                            }
                          },
                          leading: const Icon(Icons.type_specimen,
                              color: AppColors.primaryBlue),
                          title: const Text('Rings',
                              style: AppFontStyle.primaryBody),
                          subtitle: Text(
                            selectedFrequency,
                            style: AppFontStyle.secondaryBody,
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Consumer<ScheduleProvider>(
                      builder: (context, scheduleProvider, child) =>
                          ElevatedButton(
                        onPressed: () {
                          final randomID = int.parse(uuid
                              .v4()
                              .replaceAll(RegExp(r'[^0-9]'), '')
                              .substring(0, 4));
                          if (_formKey.currentState!.validate()) {
                            // Handle schedule creation
                            scheduleProvider.createNewSchedule(
                              _scheduleController.text,
                              selectedFrequency,
                              selectedDate,
                              selectedTime,
                              randomID,
                            );

                            _scheduleController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Schedule created successfully'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Create Schedule',
                          style: AppFontStyle.primarySubHeadline.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scheduleController.dispose();
    super.dispose();
  }
}
