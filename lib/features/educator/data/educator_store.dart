import 'package:flutter/foundation.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/utils/information_util.dart';
import 'package:hedagent/features/educator/models/educator_models.dart';

/// In-memory store standing in for the educator backend. Centralized so
/// actions taken on one tab (enroll a course, add a student, send an
/// alert) are reflected everywhere else that reads it.
class EducatorStore extends ChangeNotifier {
  EducatorStore._internal() {
    _seed();
  }

  static final EducatorStore instance = EducatorStore._internal();

  final List<EducatorCourse> courses = [];
  final List<EducatorStudent> students = [];
  final List<SentAlert> sentAlerts = [];

  void _seed() {
    courses.addAll([
      EducatorCourse(
        id: 'c1',
        title: 'Open Source Development',
        code: 'CSC 405',
        lecturer: 'Dr. Falade Adeshola',
        isEnrolled: true,
      ),
      EducatorCourse(
        id: 'c2',
        title: 'Distributed Systems',
        code: 'CSC 411',
        lecturer: 'Dr. Oyedele',
        isEnrolled: true,
      ),
      EducatorCourse(
        id: 'c3',
        title: 'Modelling & Simulation',
        code: 'CSC 419',
        lecturer: 'Dr. Olaoye',
      ),
      EducatorCourse(
        id: 'c4',
        title: 'Advanced Physics',
        code: 'PHY 402',
        lecturer: 'Dr. Sarah Oni',
      ),
    ]);

    students.addAll([
      EducatorStudent(
        id: 's1',
        name: 'Elena Rodriguez',
        picPath: ImagePath.studentPicPath,
        department: 'Computer Science',
        level: 400,
        course: 'Open Source Development',
        gpa: 3.75,
        attendanceRate: 94,
        riskLabel: 'On Track',
        interventions: [
          InterventionRecord(
            title: 'Resource Shared',
            time: 'June 9',
            subtitle:
                'Recommended "Dynamic Programming Essentials" via AI Nudge.',
            status: InterventionStatus.resource,
          ),
        ],
      ),
      EducatorStudent(
        id: 's2',
        name: 'Marcus Webb',
        picPath: ImagePath.studentPicPath,
        department: 'Computer Science',
        level: 300,
        course: 'Distributed Systems',
        gpa: 2.10,
        attendanceRate: 58,
        riskLabel: 'At Risk',
        interventions: [
          InterventionRecord(
            title: 'Early Warning Sent',
            time: 'May 7',
            subtitle: 'Automated nudge sent after missed quiz in Week 2.',
            status: InterventionStatus.warning,
          ),
        ],
      ),
      EducatorStudent(
        id: 's3',
        name: 'Priya Nair',
        picPath: ImagePath.studentPicPath,
        department: 'Computer Science',
        level: 400,
        course: 'Open Source Development',
        gpa: 2.85,
        attendanceRate: 76,
        riskLabel: 'Watch',
      ),
      EducatorStudent(
        id: 's4',
        name: 'Daniel Achebe',
        picPath: ImagePath.studentPicPath,
        department: 'Physics',
        level: 200,
        course: 'Distributed Systems',
        gpa: 3.40,
        attendanceRate: 88,
        riskLabel: 'On Track',
      ),
    ]);

    sentAlerts.addAll([
      SentAlert(
        title: 'Exam Reschedule',
        body: 'Distributed Systems midterm moved to Dec 14th.',
        audience: 'Distributed Systems',
        status: AlertStatus.reminder,
        time: 'Yesterday',
      ),
    ]);
  }

  int get atRiskCount => students.where((s) => s.riskLabel == 'At Risk').length;

  int get enrolledCourseCount => courses.where((c) => c.isEnrolled).length;

  int get interventionCount =>
      students.fold(0, (sum, s) => sum + s.interventions.length);

  List<EducatorCourse> get enrolledCourses =>
      courses.where((c) => c.isEnrolled).toList();

  List<EducatorStudent> studentsAtRisk() =>
      students.where((s) => s.riskLabel != 'On Track').toList();

  List<EducatorStudent> studentsInCourse(String courseTitle) =>
      students.where((s) => s.course == courseTitle).toList();

  void toggleEnrollment(EducatorCourse course) {
    course.isEnrolled = !course.isEnrolled;
    notifyListeners();
  }

  void addStudent(EducatorStudent student) {
    students.add(student);
    notifyListeners();
  }

  void logIntervention(EducatorStudent student, InterventionRecord record) {
    student.interventions.insert(0, record);
    notifyListeners();
  }

  void sendAlert(SentAlert alert) {
    sentAlerts.insert(0, alert);
    notifyListeners();
  }
}
