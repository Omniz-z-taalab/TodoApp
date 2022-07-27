import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/util/const/notificationServices.dart';
import 'package:untitled/features/presentation/widgets/TaskWidget/TaskWidgetSchedule.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            Container(
              margin: const EdgeInsets.only(top: 20.0,left: 20.0),
              child: DatePicker(
                DateTime.now(),
                height: 80.0,
                width: 80.0,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.green,
                selectedTextColor: Colors.white,
                dateTextStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const TaskWidget(),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
