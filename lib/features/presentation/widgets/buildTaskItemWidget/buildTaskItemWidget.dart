import 'package:flutter/material.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: ( directions) {
        TodoBloc.get(context).DeletTodoDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: IconButton(
                icon: Icon(Icons.favorite,color: Colors.red,),
                onPressed: () {},
              ),
            ),
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
            SizedBox(
              width: 100,
            ),
            IconButton(
                onPressed: () {
                  print(model['id']);
                  TodoBloc.get(context)
                      .upDateTodoDatabase(status: 'completed', id: model['id']);
                },
                icon: Icon(
                  Icons.done_all,
                  color: Colors.green,
                )),

          ],
        ),
      ),
    );
