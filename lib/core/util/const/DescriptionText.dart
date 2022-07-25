import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String descrip;
  final FontWeight fontwidth;
  final double fontSize;
  final Color textColor;
  const DescriptionText({Key? key,required this.descrip,required this.fontwidth,required this.fontSize,required this.textColor}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            descrip,
            style: TextStyle(color: textColor, fontSize: fontSize,fontWeight: fontwidth),



          ),
        ),
      ),
    );
  }
}