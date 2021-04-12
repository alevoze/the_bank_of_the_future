import 'package:flutter/material.dart';

class SizeConfig{
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

}

// GET ukuran tinggi yang sesuai dengan layar
double getProportionateScreenHeight(double inputHeight){
  double screenHeight = SizeConfig.screenHeight;
  //812 adalah tinggi yang biasa digunakan constrain layout
  return (inputHeight / 812) * screenHeight;
}

//GET ukuran lebar yang sesuai layar
double getProportionateScreenWidth(double inputWidth){
  double screenWidth = SizeConfig.screenWidth;
  //375 adalah lebar yang biasa digunakan constrain layout
  return (inputWidth / 375) * screenWidth;
}