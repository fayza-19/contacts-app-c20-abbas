import 'package:flutter/material.dart';
import '../core/colors_manger.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bg,
      body:
      Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Column(
                    children: [
                      Image.asset("assets/images/logoo.png"),
                    ],
                  ),

                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          const Text(
                            "There is No Contacts Added Here",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ]

            ),

          ),

        ),

      ) ,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: ColorsManager.baige,
        child: const Icon(Icons.add),
      ),

    );
  }
}