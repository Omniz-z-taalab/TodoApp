
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';

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

              border: Border.all(color: Colors.green),
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
