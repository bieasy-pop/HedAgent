import 'package:hedagent/constants/utils/information_util.dart';

class EducatorCourse {
  EducatorCourse({
    required this.id,
    required this.title,
    required this.code,
    required this.lecturer,
    this.isEnrolled = false,
  });

  final String id;
  final String title;
  final String code;
  final String lecturer;
  bool isEnrolled;
}

class InterventionRecord {
  const InterventionRecord({
    required this.title,
    required this.time,
    required this.subtitle,
    required this.status,
  });

  final String title;
  final String time;
  final String subtitle;
  final InterventionStatus status;
}

class EducatorStudent {
  EducatorStudent({
    required this.id,
    required this.name,
    required this.picPath,
    required this.department,
    required this.level,
    required this.course,
    required this.gpa,
    required this.attendanceRate,
    required this.riskLabel,
    List<InterventionRecord>? interventions,
  }) : interventions = interventions ?? [];

  final String id;
  final String name;
  final String picPath;
  final String department;
  final int level;
  String course;
  num gpa;
  num attendanceRate;
  String riskLabel;
  final List<InterventionRecord> interventions;
}

class SentAlert {
  const SentAlert({
    required this.title,
    required this.body,
    required this.audience,
    required this.status,
    required this.time,
  });

  final String title;
  final String body;
  final String audience;
  final AlertStatus status;
  final String time;
}
