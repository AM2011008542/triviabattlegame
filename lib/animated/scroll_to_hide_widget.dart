import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


 // did not  use this widget yet //


class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHideWidget(ScrollController scrollController, {
    Key? key, required this.child, required this.controller,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  _ScrollToHideWidgetState createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener((listen));
  }

  @override
  void dispose() {
    widget.controller.addListener((listen));
    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if(direction == ScrollDirection.forward) {
      show();
    } else if(direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) {
      setState(() => isVisible = true);
    }
  }
  void hide() {
    if (isVisible) {
      setState(() => isVisible = false);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: widget.duration,
    height: isVisible ? kBottomNavigationBarHeight : 0,
    child: widget.child,
  );
}