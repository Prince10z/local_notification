import 'package:get/get.dart';

class ScheduleController extends GetxController {
  RxMap<int, DateTime> Scheduledata = <int, DateTime>{}.obs;

  void addActualdata(Map<int, DateTime> data) {
    Scheduledata.addAll(data);
    print(Scheduledata);
  }

  void deleteActualdata(int num) {
    Scheduledata.remove(num);
  }

  void deleteSchedules() {
    Scheduledata.clear();
  }

  void removeEntriesIfTimePassed() {
    DateTime currentTime = DateTime.now();

    List<int> keysToRemove = [];

    if (Scheduledata.isNotEmpty) {
      for (var key in Scheduledata.keys) {
        print(key);
        if (Scheduledata[key]!.isBefore(currentTime)) {
          keysToRemove.add(key);
          print("yes");
        }
      }

      // Remove identified keys
      for (var key in keysToRemove) {
        Scheduledata.remove(key);
      }
    }
  }
}
