import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = TodoBloc.get(context).allTasks;
        return Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildItem(cubit[index],context),
            separatorBuilder: (context, index) => const SizedBox(
              height: 15.0,
            ),
            itemCount: cubit.length,
          ),
        );
      },
    );
  }
  Color getColorFrom(String colorStr) {

    String valueString =
    colorStr.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  Widget buildItem(Map model,context) => Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: ( directions) {
      TodoBloc.get(context).DeletTodoDatabase(id: model['id']);
    },
    child: Column(
      children: [
        Row(
          children:
          [

            Expanded(
              child: Text(
                '${model['date']}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
            color: getColorFrom(model['color']),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['startTime']}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundCheckBox(
                      onTap: (selected) {},
                      size: 20.0,
                      checkedColor: Colors.green,
                    ),
                  ],
                ),
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}