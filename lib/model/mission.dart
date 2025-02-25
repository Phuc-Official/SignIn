import 'package:flutter/material.dart';

class Mission {
  final String postId;
  final String title;
  final String? description;
  final String type;
  final String username;
  final DateTime dataPublished;
  final String postUrl;
  final String timeLeft;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final String workingTime;
  final String repeat;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Mission({
    required this.postId,
    required this.title,
    this.description,
    required this.type,
    required this.username,
    required this.dataPublished,
    required this.postUrl,
    required this.timeLeft,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.workingTime,
    required this.repeat,
    required this.startTime,
    required this.endTime,
  });
}
