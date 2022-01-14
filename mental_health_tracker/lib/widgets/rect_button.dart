import 'package:flutter/material.dart';

class RectButton extends StatelessWidget {
  const RectButton(
      {Key? key,
      required this.onPressed,
      required this.ic,
      })
      : super(key: key);

  final VoidCallback onPressed;
  final Icon ic;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: 3.0,
        splashColor: Colors.amber,
        height:60.0,
        minWidth: 60.0,
        child: ic,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onPressed);
  }
}
