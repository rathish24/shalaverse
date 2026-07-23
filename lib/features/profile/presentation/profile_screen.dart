import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Alex Student',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'alex.student@shalaverse.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.badge_outlined),
              title: const StringText('Role'),
              trailing: const Chip(label: Text('Student')),
            ),
            ListTile(
              leading: const Icon(Icons.school_outlined),
              title: const StringText('Grade / Class'),
              trailing: const Text('Grade 10 - Section A'),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const StringText('Notifications'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.security_outlined),
              title: const StringText('Security & Privacy'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class StringText extends StatelessWidget {
  const StringText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
