import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String text;
  const SuccessDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green,),
          SizedBox(width: 10,),
          Expanded(child: Text(text),)
        ],),
    );
  }
}