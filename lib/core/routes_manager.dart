
import 'package:contacts/features/homescreen.dart';
import 'package:flutter/material.dart';

abstract class RoutesManager {
 static const String homescreen = "/homescreen";

 static  Map<String , WidgetBuilder> routes = {
  homescreen: (context) => Homescreen(),


  };
}
