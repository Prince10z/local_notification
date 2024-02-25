import "dart:async";
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:get/get.dart";
import "package:local_notification/Controllers/ListControllers.dart";
import "package:local_notification/Screens/Home_Screen.dart";
import "package:local_notification/notifi_service.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
  await LocalNotifications.init();

  ScheduleController controller = Get.put(ScheduleController());
  Timer.periodic(Duration(seconds: 1), (Timer timer) {
    controller.removeEntriesIfTimePassed();
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
