import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';

Color getColorFrom(String colorStr) {

  String valueString =
  colorStr.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}

Widget ItmebuildTaskSchedule(Map model,context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: ( directions) {
    TodoBloc.get(context).DeletTodoDatabase(id: model['id']);
  },
  direction: DismissDirection.endToStart,
  background: Padding(
    padding: const EdgeInsets.only(top:43.0,left: 10,right: 10),
    child: Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(color: Colors.red,
          borderRadius: BorderRadius.circular(15)),
      child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.black,
          )),
    ),
  ),
  child: Column(
    children: [

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
              Padding(
                padding: const EdgeInsets.only(top: 15.0,left: 15),
                child: Text(
                  '${model['title']}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '${model['startTime']}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);