import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_bank_of_the_future/utils/size_config.dart';

class FormPasswordError extends StatelessWidget {
  const FormPasswordError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
          errors.length, (index) => formErrorText(
            error: errors[index]
        ),
        )
    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: [
        Image.asset("assets/icons/Error.svg",),
        SizedBox(width: getProportionateScreenWidth(10.0),),
        Text(error, style: TextStyle(
            color: Colors.red
        ),),
      ],
    );
  }
}