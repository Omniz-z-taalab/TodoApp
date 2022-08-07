import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/core/util/const/DescriptionText.dart';
import 'package:untitled/core/util/const/notificationServices.dart';
import 'package:untitled/features/presentation/widgets/bottons/MyBotton.dart';
import 'package:untitled/features/presentation/widgets/forms/myTextForm.dart';
import 'package:hexcolor/hexcolor.dart';

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
  final _formKey = GlobalKey<FormState>();

  int index = -1;

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
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: DescriptionText(
                            descrip: 'Title',
                            fontwidth: FontWeight.bold,
                            fontSize: 15,
                          textColor:  Theme.of(context).canvasColor,
                      ),),
                      MyTextForm(
                        controller: cubit.titleController,
                        type: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'date must not be empty';
                          }
                          return null;
                        },
                        radius: 10.0,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 20.0),
                        child:  DescriptionText(
                            descrip: 'Date',
                            fontwidth: FontWeight.bold,
                            fontSize: 15,
                            textColor: Theme.of(context).canvasColor),
                      ),
                      MyTextForm(
                        controller: cubit.dateController,
                        type: TextInputType.datetime,
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
                        validator: (String? value) {},
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children:  [
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: DescriptionText(
                                descrip: 'Start Time',
                                fontwidth: FontWeight.bold,
                                fontSize: 15,
                                textColor: Theme.of(context).canvasColor),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: DescriptionText(
                                descrip: 'End Time',
                                fontwidth: FontWeight.bold,
                                fontSize: 15,
                                textColor:  Theme.of(context).canvasColor),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: DescriptionText(
                            descrip: 'Remind',
                            fontwidth: FontWeight.bold,
                            fontSize: 15,
                            textColor:  Theme.of(context).canvasColor),
                      ),
                      DropdownButtonFormField<String>(
                        dropdownColor:Theme.of(context).backgroundColor ,
                        value: minsController,
                        validator: (val) {
                          if (val == null) {
                            return 'required';
                          }
                          return null;
                        },
                        items: [
                          '1 day before',
                          '1 hour' ,
                          '30 Min',
                          '10 Min',
                          '1 Min'
                        ]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toString(),style: TextStyle(
                                    color:  Theme.of(context).canvasColor
                                  ),),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            cubit.remindController.text = val.toString();
                          });
                        },
                        decoration: InputDecoration(

                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          fillColor:  Theme.of(context).backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Choose Your Color',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color:  Theme.of(context).canvasColor
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 160.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color:  Theme.of(context).backgroundColor,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  TodoBloc.get(context).colorController.text =
                                      HexColor('FF748C').toString();
                                  setState(() {
                                    index = 0;
                                  });
                                },
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                        width: 2,
                                        color: index == 0
                                            ? HexColor('FF748C')
                                            :  Theme.of(context).backgroundColor),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: HexColor('FF748C'),
                                      size: 25.0,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: DescriptionText(
                                          descrip: 'Pink',
                                          fontwidth: FontWeight.bold,
                                          fontSize: 20,
                                          textColor: HexColor('FF748C')),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  TodoBloc.get(context).colorController.text =
                                      HexColor('4FD77C').toString();
                                  setState(() {
                                    index = 1;
                                  });
                                },
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                        width: 2,
                                        color: index == 1
                                            ? HexColor('4FD77C')
                                            :  Theme.of(context).backgroundColor),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: HexColor('4FD77C'),
                                      size: 25.0,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    DescriptionText(
                                        descrip: 'Green',
                                        fontwidth: FontWeight.bold,
                                        fontSize: 20,
                                        textColor: HexColor('4FD77C'))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  TodoBloc.get(context).colorController.text =
                                      HexColor('C04FD7').toString();
                                  setState(() {
                                    index = 2;
                                  });
                                },
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                        width: 2,
                                        color: index == 2
                                            ? HexColor('C04FD7')
                                            :  Theme.of(context).backgroundColor),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: HexColor('C04FD7'),
                                      size: 25.0,
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    DescriptionText(
                                        descrip: 'Purple',
                                        fontwidth: FontWeight.bold,
                                        fontSize: 20,
                                        textColor: HexColor('C04FD7'))
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      MyButton(
                        isUpperCase: false,
                        text: 'Create a Task',
                        onPressedButton: () {
                          if(_formKey.currentState!.validate()){
                          cubit.insertToDatabase(
                            title: cubit.titleController.text,
                            date: cubit.dateController.text,
                            startTime: cubit.startTimeController.text,
                            endTime: cubit.endTimeController.text,
                            remind: cubit.remindController.text,
                            color: cubit.colorController.text,
                          );
                        }
                          },
                        radius: 10.0,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
