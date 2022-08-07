import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';

Color getColorFrom(String colorStr) {
  String valueString = colorStr.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}

var clocc;

bool isChecked = true;

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (directions) {
        TodoBloc.get(context).DeletTodoDatabase(id: model['id']);
      },
      direction: DismissDirection.endToStart,
      background: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(color: Colors.red),
          child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.black,
              )),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).backgroundColor
          ),
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: IconButton(
                    onPressed: () {
                      if (model['status'] == "completed") {
                        TodoBloc.get(context)
                            .upDateTodoDatabase(status: 'new', id: model['id']);
                      } else if (model['status'] == "new") {
                        TodoBloc.get(context).upDateTodoDatabase(
                            status: 'completed', id: model['id']);
                      }
                    },
                    icon: model['status'] == 'new'
                        ? Icon(
                            Icons.check_box_outlined,
                            size: 25,
                            color: getColorFrom(model['color']),
                          )
                        : Icon(
                            Icons.check_box_rounded,
                            size: 25,
                            color: getColorFrom(model['color']),
                          ),
                  )),
              Container(
                child: Text('${model['title']}',
                    style: Theme.of(context).textTheme.title),
              ),
              SizedBox(
                width: 120,
              ),
              IconButton(
                onPressed: () {
                  if (model['favorite'] == "favorite") {
                    TodoBloc.get(context)
                        .upDateFavoriteTasks(favorite: 'new', id: model['id']);
                  } else if (model['favorite'] == "new") {
                    TodoBloc.get(context).upDateFavoriteTasks(
                        favorite: 'favorite', id: model['id']);
                  }
                },
                icon: model['favorite'] == 'new'
                    ? Icon(
                        Icons.favorite_border,
                        color: getColorFrom(model['color']),
                      )
                    : Icon(
                        Icons.favorite,
                        color: getColorFrom(model['color']),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
