import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_demo/app/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(
      height: 80.w,
      width: 80.w,
      child: Lottie.asset('$assetsAnimations/cinema_loading.json'),
    ));
  }
}