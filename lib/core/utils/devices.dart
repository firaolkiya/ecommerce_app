import 'package:flutter/widgets.dart';

class AppDevices{
  AppDevices._();

  static double getDeviceWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
static double getDeviceHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }


}