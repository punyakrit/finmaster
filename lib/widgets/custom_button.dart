import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;


  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all( Colors.deepPurpleAccent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
      ),
      ),
      ),
      child: Text(text , style: const TextStyle(fontSize: 16),),
    );
  }
}
