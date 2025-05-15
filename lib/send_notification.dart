import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({super.key});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {

  @override
  void initState() {
    notificationPermission();
    super.initState();
  }

  notificationPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(width: double.infinity), TextButton(onPressed: () async => await notificationApi(), child: const Text("Send Notification"))],
      ),
    );
  }

  Future<void> notificationApi() async {
    var request = http.MultipartRequest('POST', Uri.parse('https://s9c0vkj4-3030.inc1.devtunnels.ms/api/auth/pushNotification'));
    request.fields.addAll({'deviceToken': NotificationDevice.deviceToken ?? ''});
    
    http.StreamedResponse response = await request.send();
    print('=-=-=-=-=-=-${response.statusCode}');
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

class NotificationDevice {
  static String? deviceToken;
}
