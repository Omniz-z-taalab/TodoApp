import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/features/presentation/widgets/bottons/AddTassBotton.dart';
import 'package:untitled/features/presentation/widgets/buildTaskItemWidget/ItembuilderCompleted.dart';
import 'package:untitled/features/presentation/widgets/buildTaskItemWidget/buildTaskItemWidget.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({Key? key}) : super(key: key);

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TodoBloc, TodoStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = TodoBloc.get(context).completedTasks;
        return Column(
            children:[ Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => buildTaskCompletedItem(cubit[index], context),
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
