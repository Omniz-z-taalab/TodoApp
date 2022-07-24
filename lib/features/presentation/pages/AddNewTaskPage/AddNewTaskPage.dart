import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/features/presentation/widgets/bottons/MyBotton.dart';
import 'package:untitled/features/presentation/widgets/forms/myTextForm.dart';

String? color;
String? valueController;
String? minsController;

class AddTask extends StatefulWidget {
  const AddTask({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoStates>(
      listener: (context, state) {
        if (state is TodoInsertDatabaseStates) {
          print('eeeeee');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = TodoBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Task',
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_outlined))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MyTextForm(
                    controller: cubit.titleController,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Title';
                      }
                      return null;
                    },
                    radius: 10.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MyTextForm(
                    controller: cubit.dateController,
                    type: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Date';
                      }
                      return null;
                    },
                    radius: 10.0,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2025-08-31'),
                      ).then((value) {
                        cubit.dateController.text =
                            DateFormat.yMMMd().format(value!);
                        debugPrint(DateFormat.yMMMd().format(value));
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Start Time',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'End Time',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextForm(
                          controller: cubit.startTimeController,
                          type: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Start Date';
                            }
                            return null;
                          },
                          radius: 10.0,
                          suffix: Icons.watch_later_outlined,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              cubit.startTimeController.text =
                                  value!.format(context);
                              debugPrint(value.format(context));
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: MyTextForm(
                          controller: cubit.endTimeController,
                          type: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your End date';
                            }
                            return null;
                          },
                          radius: 10.0,
                          suffix: Icons.watch_later_outlined,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              cubit.endTimeController.text =
                                  value!.format(context);
                              debugPrint(value.format(context));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Remind',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: minsController,
                    validator: (val) {
                      if (val == null) {
                        return 'required';
                      }
                      return null;
                    },
                    items: [
                      '1 day before',
                      '1 hour' '30 Mins',
                      '10 Mins',
                      '1 Mins'
                    ]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        cubit.remindController.text = val.toString();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Text(
                            'Choose the color',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Red',
                                groupValue: color,
                                onChanged: (value) {},
                                fillColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              const Text(
                                'Red',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'blue',
                                groupValue: color,
                                onChanged: (value) {},
                                fillColor:
                                    MaterialStateProperty.all(Colors.blue),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              const Text(
                                'Blue',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Amber',
                                groupValue: color,
                                onChanged: (value) {},
                                fillColor:
                                    MaterialStateProperty.all(Colors.amber),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              const Text(
                                'Amber',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  MyButton(
                    isUpperCase: false,
                    text: 'Create a Task',
                    onPressedButton: () {
                      cubit.insertToDatabase(
                        title: cubit.titleController.text,
                        date: cubit.dateController.text,
                        startTime: cubit.startTimeController.text,
                        endTime: cubit.endTimeController.text,
                        remind: cubit.remindController.text,
                      );
                    },
                    radius: 10.0,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
