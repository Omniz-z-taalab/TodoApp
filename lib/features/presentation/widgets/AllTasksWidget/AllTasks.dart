import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/features/presentation/pages/AddNewTaskPage/AddNewTaskPage.dart';
import 'package:untitled/features/presentation/widgets/bottons/AddTassBotton.dart';
import 'package:untitled/features/presentation/widgets/buildTaskItemWidget/buildTaskItemWidget.dart';



class AllTasks extends StatelessWidget {
  final bool shouldCheck;
  final bool shouldCheckDefault;

  const AllTasks({
    Key? key,
    this.shouldCheck = false,
    this.shouldCheckDefault = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       BlocConsumer<TodoBloc, TodoStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = TodoBloc.get(context).allTasks;
          return Column(
            children:[ Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => buildTaskItem(cubit[index], context),
                separatorBuilder: (context, index) => Divider(
                  height: 1.0,
                  color: Colors.grey[350],
                ),
                itemCount: cubit.length,

              ),

            ),
              SizedBox(
                height: 30,
              ),
              AddTasskButton(
                text: 'Add a task',
                color: Colors.green,
                onClicked: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask()));
                },
              ),
         ]);
        },

    );
  }}
