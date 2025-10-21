import 'package:flutter/material.dart';

@immutable
class OnboardingPageModel {
  final String title;
  final String subtitle;
  final IconData icon;

  const OnboardingPageModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
