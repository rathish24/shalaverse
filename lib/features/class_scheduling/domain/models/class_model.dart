import 'package:equatable/equatable.dart';

/// Represents the lifecycle state of a scheduled class
enum ClassStatus {
  scheduled,
  started,
  completed,
  cancelled,
  missed,
}

class ScheduledClass extends Equatable {
  const ScheduledClass({
    required this.id,
    required this.subject,
    required this.teacherName,
    required this.scheduledStartTime,
    required this.status,
  });

  final String id;
  final String subject;
  final String teacherName;
  final DateTime scheduledStartTime;
  final ClassStatus status;

  @override
  List<Object?> get props => [id, subject, teacherName, scheduledStartTime, status];
}
