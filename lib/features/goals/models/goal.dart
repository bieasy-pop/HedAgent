/// An intervention logged against a goal. The backend hasn't nailed down
/// this shape yet (the API only ever returns an empty `interventions`
/// array so far), so parsing is deliberately lenient: it reads whichever
/// of the common field names shows up and keeps the raw JSON around so
/// nothing is lost if the schema is stricter than expected.
class GoalIntervention {
  const GoalIntervention({
    this.id,
    this.type,
    this.message,
    this.createdAt,
    required this.raw,
  });

  final String? id;
  final String? type;
  final String? message;
  final DateTime? createdAt;
  final Map<String, dynamic> raw;

  factory GoalIntervention.fromJson(Map<String, dynamic> json) {
    return GoalIntervention(
      id: json['id']?.toString(),
      type:
          json['type'] as String? ??
          json['intervention_type'] as String? ??
          json['status'] as String?,
      message:
          json['message'] as String? ??
          json['description'] as String? ??
          json['note'] as String? ??
          json['summary'] as String?,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      raw: json,
    );
  }
}

class Goal {
  const Goal({
    required this.id,
    required this.studentId,
    required this.description,
    this.aiSummary,
    this.createdAt,
    this.interventions = const [],
  });

  final String id;
  final String studentId;
  final String description;
  final String? aiSummary;
  final DateTime? createdAt;
  final List<GoalIntervention> interventions;

  factory Goal.fromJson(Map<String, dynamic> json) {
    final interventionsJson = json['interventions'];
    return Goal(
      id: json['id']?.toString() ?? '',
      studentId: json['student_id']?.toString() ?? '',
      description: json['description'] as String? ?? '',
      aiSummary: json['ai_summary'] as String?,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      interventions: interventionsJson is List
          ? interventionsJson
                .whereType<Map<String, dynamic>>()
                .map(GoalIntervention.fromJson)
                .toList()
          : const [],
    );
  }
}
