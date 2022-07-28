import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';

Color getColorFrom(String colorStr) {
  String valueString = colorStr.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}

int? current = 0;
bool value = false;

Widget favoritesTasks(Map model, context) => Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text('${model['title']}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 20)),
                ),
              ),
            ),
            SizedBox(
              width: 150,
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
              icon: model['favorite'] == 'favorite'
                  ? Icon(
                Icons.favorite,
                color: getColorFrom(model['color']),
              )
                  : Icon(
                Icons.favorite_border,
                color: getColorFrom(model['color']),
              ),
            ),
          ],
        ),

    ));
