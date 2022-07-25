
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';

Color getColorFrom(String colorStr) {

  String valueString =
  colorStr.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}
int? current  = 0;

Widget favoritesTasks(Map model, context) => Dismissible(
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
            child: InkWell(
              onTap: (){
                print(model['id']);
                TodoBloc.get(context)
                    .upDateTodoDatabase(status: 'completed', id: model['id']);
                print('ay7agaaaaaaaaaaaaa');
                TodoBloc.get(context).ChangeColorName();
                print(current);
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                   color: TodoBloc.get(context).ChangeColorName() == 1 ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: getColorFrom(model['color']),width: 3.0),
                ),
              ),
            )
        ),

        Container(
          child: Text(
              '${model['title']}',
              style:
              TextStyle(fontWeight: FontWeight.normal, color:  Colors.black,fontSize: 20)),
        ),

        SizedBox(
          width: 100,
        ),
        IconButton(
            onPressed: () {
              print(model['id']);
              TodoBloc.get(context)
                  .upDateTodoDatabase(status: 'favorite', id: model['id']);
            },
            icon: Icon(
                Icons.favorite_border,
                color:  getColorFrom(model['color'])
            )),

      ],
    ),
  ),
);
