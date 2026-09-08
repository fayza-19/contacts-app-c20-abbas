import 'package:contacts/core/routes_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main (){
runApp(Contacts());

}
class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: RoutesManager.routes,
      initialRoute: RoutesManager.splash,
    );
  }
}
