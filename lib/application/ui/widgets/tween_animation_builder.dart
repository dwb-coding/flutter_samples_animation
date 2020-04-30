import 'package:flutter/material.dart';

class ColorTweenAnimationBuilder extends StatelessWidget {
  final ColorTween colorTween;

  ColorTweenAnimationBuilder({Key key, this.colorTween }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Stack(
        children: <Widget>[
          Center(
            child: TweenAnimationBuilder<Color>(
              tween: colorTween,
              duration: const Duration(milliseconds: 2000),
              builder: (BuildContext context, Color value, Widget child) =>
                  Text("Tween animation"),
            ),
          ),
        ],
      );
}
