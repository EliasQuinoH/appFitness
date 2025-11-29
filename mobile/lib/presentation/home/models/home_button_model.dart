// lib/presentation/home/models/home_button_model.dart
import 'package:flutter/material.dart';

class HomeButtonModel {
  final String title;
  final String imagePath;
  final String soundPath;
  final VoidCallback onTap;
  final double? fontSize;

  HomeButtonModel({
    required this.title,
    required this.imagePath,
    required this.soundPath,
    required this.onTap,
    this.fontSize,
  });
}
