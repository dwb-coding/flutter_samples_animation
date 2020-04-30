import 'package:flutter/material.dart';

class TouchCard extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final String label;
  TouchCard({@required this.child, @required this.onPressed, this.label = ""});

  @override
  Widget build(BuildContext context) =>
      InkWell(
        onTap: onPressed,
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(label),
              ),
              Center(child: child),
            ],
          ),
        ),
      );
}