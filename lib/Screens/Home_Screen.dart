import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_notification/Controllers/ListControllers.dart';
import 'package:local_notification/Screens/another_page.dart';
import 'package:local_notification/notifi_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScheduleController controller;
  TextEditingController todoController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  @override
  void initState() {
    controller = Get.put(ScheduleController());

    listenToNotification();
    // TODO: implement initState

    super.initState();
  }

  //to listen any notification clicked or not
  listenToNotification() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AnotherPage(payload: event)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Local Notification"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // NotificationService()
                      //     .showNotification(title: 'Sample title', body: "It works!");
                      LocalNotifications.showSimpleNotification(
                          title: todoController.text.trim(),
                          body: discriptionController.text.trim(),
                          payload: "test");
                    },
                    label: const Text("Show Notifications")),
                ElevatedButton.icon(
                    onPressed: () {
                      LocalNotifications.showPeriodicNotifications(
                          title: todoController.text.trim(),
                          body: discriptionController.text.trim(),
                          payload: "This is a periodic Notification");
                    },
                    icon: Icon(Icons.timer_outlined),
                    label: Text("Periodic_Notifications")),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: todoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Todo"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: discriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Discription"),
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      DateTime? selectedDateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (selectedDateTime != null) {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );

                        if (selectedTime != null) {
                          DateTime scheduledDateTime = DateTime(
                            selectedDateTime.year,
                            selectedDateTime.month,
                            selectedDateTime.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                          if (scheduledDateTime.isAfter(DateTime.now())) {
                            LocalNotifications.showScheduleNotification(
                              title: todoController.text.trim(),
                              body: discriptionController.text.trim(),
                              payload:
                                  "This is the testcase of Scheduled Notification",
                              scheduledTime: scheduledDateTime,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Invelid Selection",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
                    icon: Icon(Icons.schedule_outlined),
                    label: Text("Schedule Notification")),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Obx(() => Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            // itemCount: controller.Listdata.length,
                            itemCount: controller.Scheduledata.length,
                            itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey.shade300),
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Text(controller.Scheduledata[index].value),
                                      Text(controller.Scheduledata.values
                                          .toList()[index]
                                          .toString()),

                                      IconButton(
                                          onPressed: () {
                                            LocalNotifications
                                                .cancelNotification(int.parse(
                                                    controller.Scheduledata.keys
                                                        .toList()[index]
                                                        .toString()));
                                            controller.deleteActualdata(
                                                controller.Scheduledata.keys
                                                    .toList()[index]);
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                )),
                      )),
                ),
                // to close periodic notification
                TextButton(
                    onPressed: () {
                      LocalNotifications.cancelNotification(1);
                    },
                    child: Text("Close Periodic Notifications")),
                TextButton(
                    onPressed: () {
                      LocalNotifications.cancelAll();
                      controller.deleteSchedules();
                    },
                    child: Text("Cancel All Notificaiton"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
