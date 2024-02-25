import 'package:flutter/material.dart';
import 'package:local_notification/notifi_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Local Notification"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // NotificationService()
              //     .showNotification(title: 'Sample title', body: "It works!");
              LocalNotifications.showSimpleNotification(
                  title: "test", body: "case", payload: "test");
            },
            child: Text("Show Notifications")),
      ),
    );
  }
}
