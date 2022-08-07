import 'package:flutter/material.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/features/presentation/pages/Schedule/Schedule.dart';
import 'package:untitled/features/presentation/widgets/BoardWidget/bord_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Board',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_today_rounded,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ScheduleScreen()));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.brightness_3_rounded,
            ),
            onPressed: () {
              TodoBloc.get(context).changeMode();
            },
          ),
        ],
      ),
      body: const MyBoardPage(),
    );
  }
}
