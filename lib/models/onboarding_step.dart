import 'package:flutter/material.dart';

/// Represents a single contextual guidance step in the operator onboarding tour
class OnboardingStep {
  final String title;
  final String description;
  final GlobalKey targetKey;
  final Alignment cardAlignment;

  OnboardingStep({
    required this.title,
    required this.description,
    required this.targetKey,
    this.cardAlignment = Alignment.center,
  });
}
