import 'package:flutter/material.dart';
import 'package:the_bank_of_the_future/utils/style.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key, this.text, this.press, this.style,
  }) : super(key: key);

  final String text;
  final Function press;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: primaryStrongColorStyle,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
      ),
    );
  }
}