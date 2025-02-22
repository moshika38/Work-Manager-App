import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/data/sources/data.source.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryBgColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.white,
                  child: FirebaseAuth.instance.currentUser!.photoURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Image.network(
                              FirebaseAuth.instance.currentUser!.photoURL!))
                      : DataSource.userImage(),
                ),
                const SizedBox(height: 10),
                Text(
                  'Task Manager',
                  style: AppFontStyle.primaryHeadline
                      .copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primaryBlue),
            title: const Text('Home', style: AppFontStyle.primaryBody),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.task, color: AppColors.primaryBlue),
            title: const Text('My Tasks', style: AppFontStyle.primaryBody),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading:
                const Icon(Icons.calendar_today, color: AppColors.primaryBlue),
            title: const Text('Calendar', style: AppFontStyle.primaryBody),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(color: AppColors.secondaryBgColor),
          ListTile(
            leading: const Icon(Icons.settings, color: AppColors.primaryBlue),
            title: const Text('Settings', style: AppFontStyle.primaryBody),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.primaryBlue),
            title: const Text('Logout', style: AppFontStyle.primaryBody),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
