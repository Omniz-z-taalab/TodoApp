import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
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
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 0.6,
                width: double.infinity,
                color:   Theme.of(context).backgroundColor
              ),
              const TabBar(
                // controller: _tabController,
                labelColor: Colors.black,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black87,
                indicatorWeight: 3,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Completed',
                  ),
                  Tab(
                    text: 'Un Completed',
                  ),
                  Tab(
                    text: 'Favorites',
                  ),
                ],
              ),
              Container(
                height: 0.6,
                width: double.infinity,
                color:  Theme.of(context).backgroundColor
              ),
               Expanded(
                child: TabBarView(
                  // controller: _tabController,
                  children: [
                    AllTasksWidget(),
                    CompletedWidget(),
                    UnCompletedWidget(),
                    FavoritesWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}