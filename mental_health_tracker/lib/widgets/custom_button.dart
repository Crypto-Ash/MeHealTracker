import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      required this.height,
      required this.width})
      : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: height,
        minWidth: width,
        child: Text(buttonText,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Farro', fontSize: 14.0)),
        padding: const EdgeInsets.only(left: 1.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.white, width: 1.0)),
        onPressed: onPressed);
  }
}