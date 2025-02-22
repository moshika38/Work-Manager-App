 
import 'package:flutter/material.dart';
import 'package:task_manager/components/loading.bar.dart';
import 'package:task_manager/core/navigation/navigation.dart';
import 'package:task_manager/core/utils/colors.dart';
import 'package:task_manager/core/utils/font.style.dart';
import 'package:task_manager/presentation/auth/services/auth.services.dart';
import 'package:task_manager/presentation/home/screens/home.screen.dart';
 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  

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
              children: [
                const Spacer(flex: 1),
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.task_alt,
                    size: 72,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // Text Section
                Text(
                  'Task Manager',
                  style: AppFontStyle.primaryHeadline.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Organize • Prioritize • Achieve',
                  style: AppFontStyle.secondarySubHeadline.copyWith(
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
                const Spacer(flex: 2),

                // Sign In Button
                _buildGoogleSingInBtn(() async {
                  LoadingBar.show(context);
                  final credential = await AuthServices().signInWithGoogle();
                  if (credential.user != null) {
                    if (context.mounted) {
                      LoadingBar.hide(context);
                      AppNavigation.pushReplacement(
                          context, const HomeScreen());
                    }
                  }
                }),
                const SizedBox(height: 40),

                // Terms Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'By continuing, you agree to our Terms & Privacy Policy',
                    style: AppFontStyle.secondaryBody.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSingInBtn(VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 32,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBgColor,
              ),
              child: Image.network(
                'https://www.google.com/favicon.ico',
                height: 20,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Sign in with Google',
              style: AppFontStyle.primarySubHeadline.copyWith(
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
