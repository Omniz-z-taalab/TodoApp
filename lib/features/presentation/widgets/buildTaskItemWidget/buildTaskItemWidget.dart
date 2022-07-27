import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';

Color getColorFrom(String colorStr) {
  String valueString = colorStr.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}
var clocc ;
bool isChecked = true;
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (directions) {
        TodoBloc.get(context).DeletTodoDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(18.0),
               // child: Container(
               //    width: 25,
               //    height: 25,
               //    decoration: BoxDecoration(
               //      color: Colors.white,
               //      borderRadius: BorderRadius.circular(7),
               //      border: Border.all(
               //          color: getColorFrom(model['color']), width: 3.0),
               //    ),
                child:
                IconButton(
                  onPressed: () {
                    if(model['status'] == "completed"){
                      TodoBloc.get(context).upDateTodoDatabase(
                          status: 'new', id: model['id']);

                    }else if(model['status'] == "new"){
                      TodoBloc.get(context).upDateTodoDatabase(
                          status: 'completed', id: model['id']);
                    }

                  },
                  icon: model['status'] == 'new' ? Icon(Icons.check_box_outlined,color: getColorFrom(model['color']),): Icon(Icons.check_box_rounded,color: getColorFrom(model['color']),),

)),
// ),
// Container(
//                     width: 25,
//                     height: 25,
//                     decoration: BoxDecoration(
//                        color: Colors.white,
//                       borderRadius: BorderRadius.circular(7),
//                       border: Border.all(
//                           color: getColorFrom(model['color']), width: 3.0),
//                     ),
//                   ),

            // The color to use for the check icon when this checkbox is checked.

            Container(
              child: Text('${model['title']}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 20)),
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
                icon: Icon(Icons.favorite_border,
                    color: getColorFrom(model['color']))),
          ],
        ),
      ),
    );
