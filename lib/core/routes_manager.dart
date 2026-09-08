import 'package:contacts/features/homescreen.dart';
import 'package:flutter/material.dart';

abstract class RoutesManager {
  static const String homescreen = "/homescreen";

  static final Map<String, WidgetBuilder> routes = {
    homescreen: (context) => const Homescreen(),
  };
}