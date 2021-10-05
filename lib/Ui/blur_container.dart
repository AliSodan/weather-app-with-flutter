import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  BlurContainer(
      {Key? key,
      required this.child,
      required this.height,
      required this.width,
      required this.margin,
      required this.leftmargin,
      required this.rightmargin})
      : super(key: key);
  final height;
  final width;
  final margin;
  final leftmargin;
  final rightmargin;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 2.0,
        ),
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * margin,
              left: MediaQuery.of(context).size.width * leftmargin,
              right: MediaQuery.of(context).size.width * rightmargin),
          height: MediaQuery.of(context).size.height * height,
          width: MediaQuery.of(context).size.width * width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.15),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
