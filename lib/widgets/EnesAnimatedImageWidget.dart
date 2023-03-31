import 'package:flutter/material.dart';

class AnimatedImageWidget extends StatefulWidget {
  late Image image;

  AnimatedImageWidget(this.image);

  @override
  _AnimatedImageWidgetState createState() => _AnimatedImageWidgetState();
}

class _AnimatedImageWidgetState extends State<AnimatedImageWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale:  1.1 +_animationController.value *0.1 ,
          child: widget.image
        );
      },
    );
  }
}