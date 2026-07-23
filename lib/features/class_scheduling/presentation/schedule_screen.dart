import 'package:flutter/material.dart';
import '../domain/models/class_model.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockClasses = [
      ScheduledClass(
        id: 'cls-1',
        subject: 'Mathematics 101',
        teacherName: 'Dr. Smith',
        scheduledStartTime: DateTime.now().add(const Duration(minutes: 30)),
        status: ClassStatus.scheduled,
      ),
      ScheduledClass(
        id: 'cls-2',
        subject: 'Physics Lab',
        teacherName: 'Prof. Davis',
        scheduledStartTime: DateTime.now().subtract(const Duration(minutes: 10)),
        status: ClassStatus.started,
      ),
      ScheduledClass(
        id: 'cls-3',
        subject: 'Chemistry Seminar',
        teacherName: 'Dr. Johnson',
        scheduledStartTime: DateTime.now().subtract(const Duration(hours: 2)),
        status: ClassStatus.completed,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Schedule'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockClasses.length,
        itemBuilder: (context, index) {
          final item = mockClasses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.subject,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      _StatusChip(status: item.status),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Teacher: ${item.teacherName}'),
                  const SizedBox(height: 12),
                  if (item.status == ClassStatus.scheduled)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, size: 18, color: Colors.amber),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Waiting for teacher to start class',
                              style: TextStyle(fontSize: 12, color: Colors.amber),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: item.status == ClassStatus.started ? () {} : null,
                    icon: const Icon(Icons.video_call),
                    label: Text(
                      item.status == ClassStatus.started
                          ? 'Join Class'
                          : 'Join Disabled',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ClassStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      ClassStatus.scheduled => (Colors.blue, 'Scheduled'),
      ClassStatus.started => (Colors.green, 'Started'),
      ClassStatus.completed => (Colors.grey, 'Completed'),
      ClassStatus.cancelled => (Colors.red, 'Cancelled'),
      ClassStatus.missed => (Colors.orange, 'Missed'),
    };

    return Chip(
      label: Text(label, style: TextStyle(color: color, fontSize: 12)),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
    );
  }
}
