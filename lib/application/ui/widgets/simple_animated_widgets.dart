import 'dart:math';

import 'package:animations/application/ui/widgets/touch_card.dart';
import 'package:flutter/material.dart';

class AnimContainer extends StatefulWidget {
  final Size size;
  final Color initialColor;
  final double initialBorderRadius;
  AnimContainer({
    Key key,
    this.size = const Size(80.0,80.0),
    this.initialColor = const Color(0xFFC62828),
    this.initialBorderRadius = 8,
  }) : super(key: key);

  @override
  _AnimContainerState createState() => _AnimContainerState();
}

class _AnimContainerState extends State<AnimContainer> {
  double _width;
  double _height;
  Color _color;
  BorderRadiusGeometry _borderRadius;
  Matrix4 _transform = Matrix4.rotationZ(5 * pi * 2.0);

  @override
  void initState() {
    _width = widget.size.width;
    _height = widget.size.height;
    _color = widget.initialColor;
    _borderRadius = BorderRadius.circular(widget.initialBorderRadius);
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          transform: _transform,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: _color,
          ),
          duration: Duration(seconds: 1),
          curve: Curves.easeOutExpo,
        ),
        onPressed: _update,
        label: 'AnimatedContainer',
      );

  void _update() {
    setState(() {
      // Create a random number generator.
      final random = Random();

      final s = context.size;

      // Generate a random width and height.
      _width = random.nextInt(s.width.floor()).toDouble() * .8;
      _height = random.nextInt(s.height.floor()).toDouble() * .8;

      // Generate a random color.
      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );

      //Matrix4.rotationZ(random.nextInt(10)/10 * pi * 2.0);
      _transform = Matrix4.identity().clone()
        ..translate(_width / 2, _height / 2)
        ..multiply(Matrix4.rotationZ(random.nextInt(18) * pi / 9))
        ..translate(-_width / 2, -_height / 2);

      // Generate a random border radius.
      _borderRadius = BorderRadius.circular(random.nextInt(30).toDouble());
    });
  }
}

class AnimCrossFade extends StatefulWidget {
  @override
  _AnimCrossFadeState createState() => _AnimCrossFadeState();
}

class _AnimCrossFadeState extends State<AnimCrossFade> {

  bool _isToggled = false;
  final _widgets = const <Widget>[
    FlutterLogo(key: ValueKey(0), style: FlutterLogoStyle.horizontal, size: 100.0),
    FlutterLogo(key: ValueKey(1), style: FlutterLogoStyle.markOnly, size: 100.0),
  ];
  void _toggleState() => setState((){
    _isToggled = !_isToggled;
  });

  @override
  Widget build(BuildContext context) {
    return TouchCard(
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 400),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: _isToggled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: _widgets[0],
        secondChild: _widgets[1],
      ),
      onPressed: _toggleState,
      label: 'AnimatedCrossFade',
    );
  }
}

// AnimatedDefaultTextStyle,
class AnimDefaultTextStyle extends StatefulWidget {
  @override
  _AnimDefaultTextStyleState createState() => _AnimDefaultTextStyleState();
}

class _AnimDefaultTextStyleState extends State<AnimDefaultTextStyle> {

  bool _isToggled = false;
  Color _color = Colors.deepPurple;
  FontWeight _weight = FontWeight.bold;

  void _toggleState() => setState((){
      _color = _isToggled ? Colors.deepPurple : Colors.red;
      _isToggled = !_isToggled;
  });

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 600),
          style: TextStyle(color: _color, fontWeight: _weight),
          curve: Curves.easeInToLinear,
          child: Text("Museum\nof the\nBible",textAlign: TextAlign.center, textScaleFactor: 2,),
        ),
        onPressed: _toggleState,
        label: 'AnimatedDefaultTextStyle',
      );
}



// AnimatedModalBarrier -> TODO( implementation not working )
class AnimModalBarrier extends StatefulWidget {
  @override
  _AnimModalBarrierState createState() => _AnimModalBarrierState();
}

class _AnimModalBarrierState extends State<AnimModalBarrier> with TickerProviderStateMixin {
  var _visible = false;
  void _toggleState() => setState((){
    _visible = !_visible;
    _controller.forward();
  });
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: AnimatedModalBarrier(
          dismissible: true,
          color: Tween(begin: Colors.white, end: Colors.blueGrey,).animate(_controller),
        ),
        onPressed: _toggleState,
        label: 'AnimatedModalBarrier',
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// AnimatedOpacity,
class AnimOpacity extends StatefulWidget {
  @override
  _AnimOpacityState createState() => _AnimOpacityState();
}

class _AnimOpacityState extends State<AnimOpacity> {

  var _opacity = 1.0;
  void _toggleState() => setState((){
    _opacity = _opacity > 0 ? 0.0 : 1.0;
  });

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _opacity,
          child: Text('Hide\nmessage',style: TextStyle(color: Colors.blueGrey), textAlign: TextAlign.center, textScaleFactor: 2,),
        ),
        onPressed: _toggleState,
        label: 'AnimatedOpacity',
      );
}

// AnimatedPadding,
class AnimPadding extends StatefulWidget {
  @override
  _AnimPaddingState createState() => _AnimPaddingState();
}

class _AnimPaddingState extends State<AnimPadding> {

  bool _isToggled = false;
  EdgeInsetsGeometry _padding = EdgeInsets.all(32.0);

  void _toggleState() => setState((){
    _padding = _isToggled ? EdgeInsets.all(32.0) : EdgeInsets.all(64.0);
    _isToggled = !_isToggled;
  });

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 600),
          padding: _padding,
          child: Container(color: Colors.greenAccent),
        ),
        onPressed: _toggleState,
        label: 'AnimatedPadding',
      );
}

// AnimatedPhysicalModel,
class AnimPhysicalModel extends StatefulWidget {
  @override
  _AnimPhysicalModelState createState() => _AnimPhysicalModelState();
}

class _AnimPhysicalModelState extends State<AnimPhysicalModel> {

  bool isToggled = false;
  Color _color = Colors.green;
  Color _shadowColor = Colors.deepPurple;
  BoxShape _shape = BoxShape.circle;
  double _elevation = 1.0;

  void _toggleState() => setState((){
    _color = isToggled ? Colors.green[900] : Colors.red[900];
    _shadowColor = isToggled ? Colors.deepPurple : Colors.black;
//    _shape = isToggled ? BoxShape.circle : BoxShape.rectangle;
    _elevation = isToggled ? 1.0 : 10.0;
    isToggled = !isToggled;
  });

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 600),
          color: _color,
          shadowColor: _shadowColor,
          shape: _shape,
          elevation: _elevation,
          child: Container(height: 100, width: 100,),
        ),
        onPressed: _toggleState,
        label: 'AnimatedPhysicalModel',
      );
}

// AnimatedPositioned (widget must be child of stack)
class AnimPositioned extends StatefulWidget {
  @override
  _AnimPositionedState createState() => _AnimPositionedState();
}

class _AnimPositionedState extends State<AnimPositioned> {

  bool _isToggled = false;
  final _width = 80.0;
  final _height = 80.0;
  double _left = 80.0, _top = 80.0;

  void _toggleState() => setState((){
    final size = context.size;
    _left = _isToggled ? 20.0 : size.width - 40 - _width;
    _top = _isToggled ? 20.0 : size.height - 40 - _height;
    _isToggled = !_isToggled;
  });

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: Stack(
          children: [
            AnimatedPositioned(
              top: _top,
              height: _height,
              left: _left,
              width: _width,
              curve: Curves.bounceOut,
              duration: const Duration(milliseconds: 900),
              child: CircleAvatar(backgroundColor: Colors.grey, child: Container(color: Colors.deepOrange, width: 40, height: 40,),),
            ),
          ],
        ),
        onPressed: _toggleState,
        label: 'AnimatedPositioned',
      );
}

// AnimatedPositionedDirectional (widget must be child of stack)
class AnimPositionedDirectional extends StatefulWidget {
  @override
  _AnimPositionedDirectionalState createState() => _AnimPositionedDirectionalState();
}

class _AnimPositionedDirectionalState extends State<AnimPositionedDirectional> {

  bool _isToggled = false;
  final _width = 80.0;
  final _height = 80.0;
  double _start = 80.0, _top = 80.0;

  void _toggleState() => setState((){
    final size = context.size;
    _start = _isToggled ? 20.0 : size.width - 40 - _width;
    _top = _isToggled ? 20.0 : size.height - 40 - _height;
    _isToggled = !_isToggled;
  });

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: Stack(
            children: <Widget>[
              AnimatedPositionedDirectional(
                duration: const Duration(milliseconds: 600),
                top: _top,
                height: _height,
                start: _start,
                width: _width,
                curve: Curves.fastOutSlowIn,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Container(color: Colors.deepOrange, width: 40, height: 40,),
                ),
              ),
            ]
        ),
        onPressed: _toggleState,
        label: 'AnimatedPositionedDirectional',
      );
}

// AnimatedSwitcher
class AnimSwitcher extends StatefulWidget {
  @override
  _AnimSwitcherState createState() => _AnimSwitcherState();
}

class _AnimSwitcherState extends State<AnimSwitcher> {

  bool isToggled = false;
  final _widgets = const <Widget>[
    Icon(Icons.school, key: ValueKey(0), color: const Color(0xFF616161), size: 100.0,),
    Icon(Icons.attach_money, key: ValueKey(1), color: const Color(0xFF2E7D32), size: 100.0,),
  ];
  var _widget;

  @override
  void initState() {
    _widget = _widgets[0];
    super.initState();
  }

  void _toggleState() => setState((){
    _widget = isToggled ? _widgets[0] : _widgets[1];
    isToggled = !isToggled;
  });

  @override
  Widget build(BuildContext context) =>
      TouchCard(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(child: child, scale: animation,),
          child: _widget,
        ),
        onPressed: _toggleState,
        label: 'AnimatedSwitcher',
      );
}



