import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/presentation/pages/Schedule/Schedule.dart';
import 'package:untitled/features/presentation/widgets/AllTasksWidget/AllTasks.dart';
import 'package:untitled/features/presentation/widgets/CompletedTasksWidget/CompletedTasks.dart';
import 'package:untitled/features/presentation/widgets/FavoritTasksWidget/FavoritTasks.dart';
import 'package:untitled/features/presentation/widgets/UnCombletedTasksWidget/UnCombletedTasks.dart';

class MyBoardPage extends StatefulWidget {
  const MyBoardPage({Key? key}) : super(key: key);

  @override
  State<MyBoardPage> createState() => _MyBoardPageState();
}

class _MyBoardPageState extends State<MyBoardPage> {
  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Board',
                style: TextStyle(color: Colors.black,fontSize: 25),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduleScreen()));
                    },
                    icon: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.green,
                    )),
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'All',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'UnComplete',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Favorite',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const AllTasks(),
              CompletedTasks(),
              UnCombletedTasks(),
              FavoritTasks(),
            ],
          )),
    );
  }
}
