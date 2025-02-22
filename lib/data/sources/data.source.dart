import 'package:flutter/material.dart';

class DataSource {
  static ClipRRect userImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Image.asset(
        'assets/img/user.jpg',
        fit: BoxFit.fill,
      ),
    );
  }
}
