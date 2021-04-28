import 'package:flutter/material.dart';
import 'package:the_bank_of_the_future/utils/style.dart';
import 'package:the_bank_of_the_future/utils/validators.dart';
import 'package:the_bank_of_the_future/widgets/default_button.dart';
import 'package:the_bank_of_the_future/widgets/form_error.dart';
import 'package:the_bank_of_the_future/widgets/title_text.dart';

class EmailSection extends StatefulWidget {
  @override
  _EmailSectionState createState() => _EmailSectionState();
}

class _EmailSectionState extends State<EmailSection> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  final List<String> errors = [];
  final List<String> errors2 = [];
  final List<String> errors3 = [];

  String email;

  void addError({String error}){
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}){
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height:50.0),
        TitleText(
          title: "Welcome to\nGIN Finans",
          subTitle: "Welcome to The Bank of The Future.\nManage and track your accounts on\nthe go.",
        ),
        SizedBox(height:20.0),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      defaultShadow
                    ]
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        defaultShadow
                      ]
                  ),
                  child: buildEmailFormField(),
                ),
              ),
              SizedBox(height:5.0),
              FormError(errors: errors),
              SizedBox(height:360.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.blueAccent,
                  child: Center(
                    child:
                    DefaultButton(
                      text: "Next",
                      press:(){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (errors.length == 0) {
                            continued();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty){
          removeError(error: emailNullError);
        }if (emailValidator.hasMatch(value)) {
          removeError(error: invalidEmailError);
        }
        return null;
      },
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty){
          addError(error: emailNullError);
          return null;
        }else if (!emailValidator.hasMatch(value)) {
          addError(error: invalidEmailError);
          return null;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Email",
        prefixIcon: Icon(Icons.email_outlined),
        border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 3 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }
}
