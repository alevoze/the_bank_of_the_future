import 'package:flutter/material.dart';
import 'package:the_bank_of_the_future/utils/size_config.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    Key key, this.title, this.subTitle,
  }) : super(key: key);
  final String title;
  final String subTitle;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 28.0,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Text(subTitle,
        ),
      ],
    );
  }
}
