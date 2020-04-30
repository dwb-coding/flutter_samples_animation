import 'package:animations/application/ui/widgets/simple_animated_widgets.dart';
import 'package:flutter/material.dart';

class AnimationsPage extends StatefulWidget {
  @override
  _AnimationsPageState createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage> {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: () {},),
          ],
        ),
        body: AnimationGrid(),
      );
}

class AnimationGrid extends StatelessWidget {
  final _widgets = <Widget>[
    Builder(builder: (BuildContext context) => AnimContainer() ),
    Builder(builder: (BuildContext context) => AnimCrossFade() ),
    Builder(builder: (BuildContext context) => AnimDefaultTextStyle() ),
    Builder(builder: (BuildContext context) => AnimModalBarrier() ),
    Builder(builder: (BuildContext context) => AnimOpacity() ),
    Builder(builder: (BuildContext context) => AnimPadding() ),
    Builder(builder: (BuildContext context) => AnimPhysicalModel() ),
    Builder(builder: (BuildContext context) => AnimPositioned() ),
    Builder(builder: (BuildContext context) => AnimPositionedDirectional() ),
    Builder(builder: (BuildContext context) => AnimSwitcher() ),
  ];

  @override
  Widget build(BuildContext context) =>
      GridView.count(
        crossAxisCount: 2,
        padding:EdgeInsets.all(8),
        children: _widgets,
      );
}




