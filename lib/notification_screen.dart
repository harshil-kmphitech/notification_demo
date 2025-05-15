import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<Map<String, String>> demoNotifications = [
    {'title': 'New Message', 'body': 'You have a new message from John.', 'time': '2 min ago'},
    {'title': 'Order Shipped', 'body': 'Your order #12345 has been shipped.', 'time': '1 hr ago'},
    {'title': 'Reminder', 'body': 'Don\'t forget your meeting at 3 PM.', 'time': 'Today'},
    {'title': 'Update Available', 'body': 'Version 2.0.1 is now available for download.', 'time': 'Yesterday'},
    {'title': 'Promo', 'body': 'Get 20% off on your next purchase!', 'time': '2 days ago'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: demoNotifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = demoNotifications[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(item['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(item['body'] ?? ''), const SizedBox(height: 4), Text(item['time'] ?? '', style: TextStyle(fontSize: 12, color: Colors.grey[600]))],
              ),
              leading: const Icon(Icons.notifications),
            ),
          );
        },
      ),
    );
  }
}
