import 'package:flutter/material.dart';

class AddTasskButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onClicked;
  const AddTasskButton({Key? key, required this.text, required this.color,this.textColor =Colors.white,required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:30.0,right: 30),
      child: Container(
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: MaterialButton(
            height: 50,
            color: color,
            onPressed: () {
              onClicked();
            },
            child: Text(text,style: TextStyle(color: textColor,fontSize: 15),),
          )),
    );
  }}
