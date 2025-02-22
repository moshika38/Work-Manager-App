import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/sources/data.source.dart';

class LeftHeader extends StatelessWidget {
  final VoidCallback pressNotification;
  final VoidCallback pressAvatar;
  const LeftHeader({
    super.key,
    required this.pressNotification,
    required this.pressAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: pressNotification,
          icon: const Icon(
            Icons.notifications_none,
            size: 35,
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: pressAvatar,
          child: CircleAvatar(
            radius: 28,
            child: FirebaseAuth.instance.currentUser!.photoURL != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                        FirebaseAuth.instance.currentUser!.photoURL!))
                : DataSource.userImage(),
          ),
        ),
      ],
    );
  }
}
