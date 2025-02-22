import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Notifications', style: AppFontStyle.primarySubHeadline),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.clear_all, color: AppColors.primaryTextColor),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          return const NotificationTile(
            icon: Icons.task_alt,
            title: 'Project Deadline',
            description: 'Team meeting for project review in 30 minutes',
            time: '2 min ago',
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String time;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryBgColor.withOpacity(0.3)),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primaryBlue),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppFontStyle.primarySubHeadline),
                Text(
                  time,
                  style: AppFontStyle.secondaryBody.copyWith(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppFontStyle.secondaryBody,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
