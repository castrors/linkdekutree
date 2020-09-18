import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const CircleButton({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.white,
      child: child,
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }
}
