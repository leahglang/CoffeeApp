import 'package:flutter/material.dart';

class MyChip extends StatelessWidget{
  final String text;
  final bool isSeleted;

  const MyChip({required this.text, required this.isSeleted});

  Widget build(BuildContext context){
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: isSeleted ? Colors.white : Colors.grey
        ),
      ),
      backgroundColor: isSeleted ? Colors.brown[400] : Colors.grey[100],
      padding: EdgeInsets.all(16),
    );
  }
}