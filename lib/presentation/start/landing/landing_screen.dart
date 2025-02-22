import 'package:flutter/material.dart';
import 'package:task_manager/core/navigation/navigation.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/presentation/auth/screens/login.screen.dart';
import 'package:task_manager/components/secondary.button.dart';
import 'package:task_manager/presentation/start/widgets/feature.point.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryBlue,
              AppColors.secondaryBlue,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Icon(
                  Icons.task_alt,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 40),
                Text(
                  'Manage Tasks\nLike Never Before',
                  style: AppFontStyle.primaryHeadline.copyWith(
                    fontSize: 40,
                    height: 1.2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Create, organize and track your tasks with our powerful task management solution',
                  style: AppFontStyle.primaryBody.copyWith(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const Spacer(),
                
                // Feature Points
                const FeaturePoint(
                  icon: Icons.check_circle_outline,
                  text: 'Smart task organization',
                ),
                const SizedBox(height: 20),
                const FeaturePoint(
                  icon: Icons.timer_outlined,
                  text: 'Track time efficiently',
                ),
                const SizedBox(height: 20),
                const FeaturePoint(
                  icon: Icons.trending_up,
                  text: 'Boost productivity',
                ),
                const SizedBox(height: 48),
                
                // Get Started Button
               SecondaryButton(
                onPressed: (){
                  AppNavigation.push(context, const LoginScreen());
                },
               ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


