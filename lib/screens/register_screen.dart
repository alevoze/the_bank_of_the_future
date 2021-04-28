import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_bank_of_the_future/screens/sections/email_section.dart';
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

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin{
  TextEditingController textController = TextEditingController();
  AnimationController _animationController;
  AnimationController _animationCalendar;
  // Animation<double> _fabScale;
  DateTime selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  // final _formKey3 = GlobalKey<FormState>();

  bool eightChars = false;
  bool specialChar = false;
  bool upperCaseChar = false;
  bool number = false;

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  String email;
  String password;
  bool remember = false;
  String _value,_value1, _value2;

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

  void addPasswordError({String error}){
    if (!errors2.contains(error)) {
      setState(() {
        errors2.add(error);
      });
    }
  }

  void removePasswordError({String error}){
    if (errors2.contains(error)) {
      setState(() {
        errors2.remove(error);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(vsync: this,
        duration: Duration(milliseconds: 500));


    _animationCalendar = AnimationController(vsync: this,
        duration: Duration(seconds: 1))
      ..forward()
      ..repeat(reverse: true);

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

    // _fabScale = Tween<double>(begin: 0, end: 1)
    //     .animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _animationCalendar.dispose();
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
                          content:  Column(
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
                          ),
                          // content:  EmailSection(),
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
                                    SizedBox(height:30.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Complexity:"),
                                      ],
                                    ),
                                    SizedBox(height:30.0),
                                    Padding(padding: const EdgeInsets.all(3.0), child: _validationStack()),
                                    SizedBox(height:300.0),
                                    DefaultButton(
                                      text: "Next",
                                      press:(){
                                        if (_formKey2.currentState.validate()) {
                                          _formKey2.currentState.save();
                                          if (eightChars == true && specialChar == true && upperCaseChar == true && number == true) {
                                            continued();
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height:30.0),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height:50.0),
                              TitleText(
                                title: "Personal Information",
                                subTitle: "Please fill in the information below and your goal\nfor digital saving.",
                              ),
                              SizedBox(height:20.0),
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
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelText: "Goal for activation",
                                      contentPadding: EdgeInsets.only(left: 20,),
                                    ),
                                    value: _value,
                                    hint: Text("- Choose Options -"),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Tech Division"),
                                        value: "Tech Division",
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Finance Division"),
                                        value: "Finance Division",
                                      ),
                                      DropdownMenuItem(
                                        child: Text(" Marketing Division"),
                                        value: "Marketing Division",
                                      )
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height:20.0),
                              Container
                                (
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
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelText: "Monthly income",
                                      contentPadding: EdgeInsets.only(left: 20,),
                                    ),
                                    value: _value,
                                    hint: Text("- Choose Options -"),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Tech Division"),
                                        value: "Tech Division",
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Finance Division"),
                                        value: "Finance Division",
                                      ),
                                      DropdownMenuItem(
                                        child: Text(" Marketing Division"),
                                        value: "Marketing Division",
                                      )
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height:20.0),
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
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        labelText: "Monthly expense",
                                      contentPadding: EdgeInsets.only(left: 20,),
                                    ),
                                    value: _value,
                                    hint: Text("- Choose Options -"),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Tech Division"),
                                        value: "Tech Division",
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Finance Division"),
                                        value: "Finance Division",
                                      ),
                                      DropdownMenuItem(
                                        child: Text(" Marketing Division"),
                                        value: "Marketing Division",
                                      )
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height:260.0),
                              DefaultButton(
                                text: "Next",
                                press:(){
                                  continued();
                                },
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
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: AnimatedBuilder(
                                  animation: _animationCalendar,
                                  builder: (context, child) {
                                    return Container(
                                      decoration: ShapeDecoration(
                                        color: Colors.blue.withOpacity(0.5),
                                        shape: CircleBorder(),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0 * _animationCalendar.value),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      onPressed: () => _selectDate(context),
                                      color: Colors.blue,
                                      icon: Icon(Icons.calendar_today, size: 24),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height:20.0),
                              TitleText(
                                title: "Shedule Video Call",
                                subTitle: "Choose the date and time that you preferred,\nwe will send a link via email to make a video call on\nthe schedule date and time.",
                              ),
                              SizedBox(height:20.0),
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
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelText: "Date",
                                      contentPadding: EdgeInsets.only(left: 20,),
                                    ),
                                    value: _value1,
                                    hint: Text("- Choose Date -"),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Kamis, 02 Des 2019"),
                                        value: "Kamis, 02 Des 2019",
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value1 = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height:20.0),
                              Container
                                (
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
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      labelText: "Time",
                                      contentPadding: EdgeInsets.only(left: 20,),
                                    ),
                                    value: _value2,
                                    hint: Text("- Choose Time -"),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("10:10"),
                                        value: "10:10",
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value2 = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height:310.0),
                              DefaultButton(
                                text: "Next",
                                press:(){
                                  continued();
                                },
                              ),
                            ],
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 3 ?
                          StepState.complete : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:20.0)
              ],
            ),
          ),
        ),
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
      validator: (value) {
        if (value.isEmpty) {
          addPasswordError(error: passNullError);
          return null;
        }else if ( value.length < 8 ) {
          addPasswordError(error: shortPassError);
          return null;
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removePasswordError(error: passNullError);
        } else if ( value.length >= 8 ) {
          removePasswordError(error: shortPassError);
        }
        return null;
      },
      onSaved: (newValue) =>  password = newValue,
      decoration: InputDecoration(
        // labelText: "Password",
        hintText: "Create Password",
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 20, top: 15),
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

  Widget _validationStack() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ValidationItem("@", specialChar, "Symbol"),
          _separator(),
          ValidationItem("A", upperCaseChar, "Uppercase"),
          _separator(),
          ValidationItem("123", number, "Number"),
          _separator(),
          ValidationItem("9+", eightChars, "Characters"),
        ]

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

