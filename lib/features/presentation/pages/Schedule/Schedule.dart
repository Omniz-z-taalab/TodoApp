import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/core/util/const/notificationServices.dart';
import 'package:untitled/features/presentation/widgets/TaskWidget/TaskWidgetSchedule.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate = DateTime.now();


  @override

  @override
  Widget build(BuildContext context) {
    String dateOfDay = DateFormat('EEEE').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Schedule',

        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: DatePicker(DateTime.now(),
                  height: 80.0,
                  width: 80.0,
                  initialSelectedDate: selectedDate,
                  selectionColor: Colors.green,
                  selectedTextColor: Colors.white,
                  dateTextStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ), onDateChange: (value) {
                dateOfDay;
              }),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(children: [
              Expanded(
                child: Text(
                  '${dateOfDay}',
                    style: Theme.of(context).textTheme.title

                ),
              ),
            ]),
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
