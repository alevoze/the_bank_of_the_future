import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.blueAccent
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
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
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email Address'),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Password'),
                            ),
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
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Home Address'),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Postcode'),
                            ),
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
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.list),
          // onPressed: switchStepsType,
          onPressed:(){},
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


}