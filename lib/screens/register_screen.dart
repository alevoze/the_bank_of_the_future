import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_bank_of_the_future/utils/size_config.dart';
import 'package:the_bank_of_the_future/utils/style.dart';
import 'package:the_bank_of_the_future/utils/validators.dart';
import 'package:the_bank_of_the_future/widgets/background_painter.dart';
import 'package:the_bank_of_the_future/widgets/default_button.dart';
import 'package:the_bank_of_the_future/widgets/form_error.dart';
import 'package:the_bank_of_the_future/widgets/form_password_error.dart';
import 'package:the_bank_of_the_future/widgets/title_text.dart';
import 'package:the_bank_of_the_future/widgets/validation_item.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin{
  TextEditingController textController = TextEditingController();
  AnimationController _animationController;
  Animation<double> _fabScale;

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  bool eightChars = false;
  bool specialChar = false;
  bool upperCaseChar = false;
  bool number = false;

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  String email;
  String password;
  bool remember = false;

  final List<String> errors = [];
  final List<String> errors2 = [];
  final List<String> errors3 = [];

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
  void initState() {
    // TODO: implement initState
    super.initState();
    // _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));

    textController.addListener(() {
      setState(() {
        eightChars = textController.text.length >= 8;
        number = textController.text.contains(RegExp(r'\d'), 0);
        upperCaseChar = textController.text.contains(new RegExp(r'[A-Z]'), 0);
        specialChar = textController.text.isNotEmpty &&
            !textController.text.contains(RegExp(r'^[\w&.-]+$'), 0);
      });

      if (_allValid()) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    _animationController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 500));

    _fabScale = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.blueAccent
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height:20.0),
                Expanded(
                  child: CustomPaint(
                    painter: BackGroundPainter(
                      animation: _animationController.view
                    ),
                    child: Stepper(
                      type: stepperType,
                      physics: ScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue:  continued,
                      onStepCancel: cancel,
                      steps: <Step>[
                        Step(
                          title: Divider(
                            thickness: 2,
                            color: Colors.white70,
                          ),
                          content: Column(
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
                                  ],
                                ),
                              ),
                              SizedBox(height:40.0)
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
                        Step(
                          title: Divider(
                            thickness: 2,
                            color: Colors.white70,
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height:50.0),
                              TitleText(
                                title: "Create Password",
                                subTitle: "Password will be used to login to account.",
                              ),
                              SizedBox(height:20.0),
                              Form(
                                key: _formKey2,
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
                                        child: buildPasswordFormField(),
                                      ),
                                    ),
                                    SizedBox(height:5.0),
                                    FormPasswordError(errors: errors2),
                                  ],
                                ),
                              ),
                              SizedBox(height:30.0),
                              Text("Complexity:"),
                              Padding(
                                  padding: const EdgeInsets.all(32.0), child: _validationStack()),

                              SizedBox(height:400.0)
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 1 ?
                          StepState.complete : StepState.disabled,
                        ),
                        Step(
                          title: Divider(
                            thickness: 2,
                            color: Colors.white70,
                          ),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Mobile Number'),
                              ),
                            ],
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 2 ?
                          StepState.complete : StepState.disabled,
                        ),
                        Step(
                          title: Divider(
                            thickness: 2,
                            color: Colors.white70,
                          ),
                          content: SizedBox(
                            height: 10,
                            width: 10,
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 3 ?
                          StepState.complete : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: primaryWeakColorStyle,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          defaultShadow
                        ]
                    ),
                    child: DefaultButton(
                      text: "Next",
                      press:(){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }
                        if (errors.length == 0) {
                          continued();
                        }
                        },

                    ),
                  ),
                ),
                SizedBox(height:20.0)
              ],
            ),
          ),
        ),
// _animationController.forward(from: 0);
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.list),
        //   // onPressed: switchStepsType,
        //   onPressed:(){
        //     continued();
        //   },
        // ),
      ),
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: textController,
      obscureText: !_showPassword,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     addError(error: passNullError);
      //     return "";
      //   }else if ( value.length < 8 ) {
      //     addError(error: shortPassError);
      //     return "";
      //   }
      //   return null;
      // },
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: passNullError);
      //   } else if ( value.length >= 8 ) {
      //     removeError(error: shortPassError);
      //   }
      //   return null;
      // },
      // onSaved: (newValue) =>  password = newValue,
      decoration: InputDecoration(
          // labelText: "Password",
          hintText: "Create Password",
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: GestureDetector(
            onTap: () {
              _togglevisibility();
            },
            child: Icon(
              _showPassword ? Icons.visibility : Icons
                  .visibility_off, color: Colors.blueAccent,),
          ),
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
  bool _allValid() {
    return eightChars && number && specialChar && upperCaseChar;
  }

  Stack _validationStack() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Card(
          shape: CircleBorder(),
          color: Colors.black12,
          child: Container(height: 150, width: 150,),),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0, left: 10),
          child: Transform.rotate(
            angle: -math.pi/20,
            child: Icon(
              Icons.lock,
              color: Colors.pink,
              size: 60,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 60),
          child: Transform.rotate(
            angle: -math.pi / -60,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 4,
              color: Colors.yellow.shade800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 4),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 8),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 74),
          child: Transform.rotate(
            angle: math.pi / -45,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ValidationItem("8 characters", eightChars),
                        _separator(),
                        ValidationItem("1 special char", specialChar),
                        _separator(),
                        ValidationItem("1 upper case", upperCaseChar),
                        _separator(),
                        ValidationItem("1 number", number)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.scale(
                      scale: _fabScale.value,
                      child: Card(
                        shape: CircleBorder(),
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget _separator() {
    return Container(
      height: 1,
      decoration: BoxDecoration(color: Colors.blue.withAlpha(100)),
    );
  }


}