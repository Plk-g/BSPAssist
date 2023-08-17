import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  void Function()? onPressed;
  MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),

      padding: EdgeInsets.only(
          left: 15,
          bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top :20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, style: TextStyle(color: Colors.grey[700]),),
              //editbutton
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.edit, color: Colors.indigo,),
              ),
           ],
          ),

          //text
          Text(text),
        ],
      )

    );
  }
}
