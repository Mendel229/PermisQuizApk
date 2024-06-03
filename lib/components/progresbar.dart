

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/progress_bar_controller.dart';
import 'colors.dart';

class Progressbar extends StatelessWidget {
  const Progressbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width:3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<ProgressController>(
        init: ProgressController(),
          builder: (controller) {
        return Stack(
        children: [
        LayoutBuilder(
        builder: (context, constraints) => Container(
        width: constraints.maxWidth * controller.animation.value,
        decoration: BoxDecoration(
        gradient: KPrimaryGradient,
        borderRadius: BorderRadius.circular(50),
        ),
        ),
        ),
        Positioned.fill(
        child: Padding(
        padding: const EdgeInsets.symmetric(
        horizontal: KDefaultPadding / 2
        ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
        Text("${(controller.animation.value * 30).round()} sec", style: TextStyle(fontSize: 18),),
        Icon(Icons.alarm, color: Colors.grey,)
        ],
        ),
        ),

        )
        ,
        ]
        ,
        );
      }
      ),
    );
  }
}
