import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/features/presentation/widgets/buildTaskItemWidget/buildTaskItemWidget.dart';

class UnCombletedTasks extends StatefulWidget {
  const UnCombletedTasks({Key? key}) : super(key: key);

  @override
  State<UnCombletedTasks> createState() => _UnCombletedTasksState();
}

class _UnCombletedTasksState extends State<UnCombletedTasks> {
  @override
  Widget build(BuildContext context) {
    return        BlocConsumer<TodoBloc, TodoStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = TodoBloc.get(context).uncompletedTasks;
        return Column(
            children:[ Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => buildTaskItem(cubit[index], context),
                separatorBuilder: (context, index) => Divider(
                  height: 1.0,
                  color: Colors.white,
                ),
                itemCount: cubit.length,
              ),
            ),
            ]);
      },

    );

  }
}
