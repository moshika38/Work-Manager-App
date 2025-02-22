import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/notifications/notification.services.dart';
import 'package:task_manager/core/providers/schedule.provider.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/presentation/home/screens/home.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_manager/presentation/start/landing/landing_screen.dart';
import 'package:task_manager/core/providers/task.provider.dart';
import 'core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  await NotificationServices.initNotification();

  

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryBgColor,
        // fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : const LandingScreen(),
    );
  }
}
