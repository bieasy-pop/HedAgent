/// In-memory mock data for the educator flow (students, courses, alerts,
/// interventions). No backend exists for this yet — screens read/write
/// these static lists directly so navigating between tabs shows a
/// consistent, evolving picture during a session.
class MockStudent {
  MockStudent({
    required this.id,
    required this.name,
    required this.matricNo,
    required this.department,
    required this.level,
    required this.riskLabel,
    required this.attendanceRate,
    required this.gpa,
  });

  final String id;
  final String name;
  final String matricNo;
  final String department;
  final String level;
  final String riskLabel;
  final double attendanceRate;
  final double gpa;
}

class MockCourse {
  MockCourse({
    required this.id,
    required this.code,
    required this.title,
    required this.studentCount,
  });

  final String id;
  final String code;
  final String title;
  final int studentCount;
}

class MockAlert {
  MockAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.target,
    required this.sentAt,
  });

  final String id;
  final String title;
  final String message;
  final String target;
  final DateTime sentAt;
}

class MockIntervention {
  MockIntervention({
    required this.studentId,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.level,
  });

  final String studentId;
  final String title;
  final String subtitle;
  final String time;
  final int level;
}

class EducatorMockStore {
  EducatorMockStore._();

  static final List<MockStudent> students = [
    MockStudent(
      id: 's1',
      name: 'Amaka Obi',
      matricNo: 'CSC/2021/001',
      department: 'Computer Science',
      level: '300',
      riskLabel: 'At Risk',
      attendanceRate: 62,
      gpa: 2.1,
    ),
    MockStudent(
      id: 's2',
      name: 'Tunde Bakare',
      matricNo: 'CSC/2021/014',
      department: 'Computer Science',
      level: '300',
      riskLabel: 'On Track',
      attendanceRate: 91,
      gpa: 3.6,
    ),
    MockStudent(
      id: 's3',
      name: 'Ngozi Eze',
      matricNo: 'SEN/2022/009',
      department: 'Software Engineering',
      level: '200',
      riskLabel: 'Warning',
      attendanceRate: 74,
      gpa: 2.8,
    ),
  ];

  static final List<MockCourse> availableCourses = [
    MockCourse(
      id: 'c1',
      code: 'CSC 301',
      title: 'Data Structures & Algorithms',
      studentCount: 62,
    ),
    MockCourse(
      id: 'c2',
      code: 'CSC 405',
      title: 'Machine Learning',
      studentCount: 38,
    ),
    MockCourse(
      id: 'c3',
      code: 'SEN 210',
      title: 'Software Requirements Engineering',
      studentCount: 45,
    ),
  ];

  static final List<MockCourse> enrolledCourses = [];

  static final List<MockAlert> alerts = [];

  static final List<MockIntervention> interventions = [
    MockIntervention(
      studentId: 's1',
      title: 'Early Warning Sent',
      subtitle: 'Automated nudge sent after missed quiz in Week 2.',
      time: 'May 7',
      level: 3,
    ),
    MockIntervention(
      studentId: 's3',
      title: 'Resource Shared',
      subtitle: 'Recommended "Dynamic Programming Essentials" via AI Nudge.',
      time: 'June 9',
      level: 1,
    ),
  ];
}
