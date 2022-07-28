import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/features/presentation/widgets/buildTaskItemWidget/itembuildTaskSchedule.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoBloc
            .get(context)
            .allTasks;
        return Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => ItmebuildTaskSchedule(cubit[index], context),
            separatorBuilder: (context, index) =>
            const SizedBox(
              height: 15.0,
            ),
            itemCount: cubit.length,
          ),
        );
      },
    );
  }
}