
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';

Color getColorFrom(String colorStr) {

  String valueString =
  colorStr.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}
Widget buildTaskUncompletedItem(Map model, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),

              border: Border.all(color: getColorFrom(model['color']),width: 3.0),
            ),
          )),
      SizedBox(
        width: 20,
      ),
      Container(
        child: Text(
          '${model['title']}',
          style:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: IconButton(onPressed: (){
          print(model['id']);
          TodoBloc.get(context).upDateTodoDatabase(status: 'new', id: model['id']);
        }, icon: Icon(Icons.clear,color: Colors.green,)),
      ),


    ],
  ),
);
