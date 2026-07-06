enum InterventionStatus { atRisk, warning, resource, recommended }

enum AlertStatus { maxRisk, minRisk, normal, reminder, intervention }

int interventionLevel(InterventionStatus? status) {
  switch (status) {
    case InterventionStatus.atRisk:
      return 4; // High intervention
    case InterventionStatus.warning:
      return 3; // Medium intervention
    case InterventionStatus.recommended:
      return 2; // Low intervention
    case InterventionStatus.resource:
      return 1; // Low intervention
    default:
      return 0; // No intervention needed
  }
}

String gradeConverter(num score) {
  if (score >= 70) {
    return 'A';
  } else if (score >= 60) {
    return 'B';
  } else if (score >= 50) {
    return 'C';
  } else if (score >= 45) {
    return 'D';
  } else if (score >= 40) {
    return 'E';
  } else {
    return 'F';
  }
}
