import 'package:flutter/material.dart';

class EAnimatedImageWidget extends StatefulWidget {
  late Image image;

  EAnimatedImageWidget(this.image);

  @override
  _EAnimatedImageWidgetState createState() => _EAnimatedImageWidgetState();
}

class _EAnimatedImageWidgetState extends State<EAnimatedImageWidget> with SingleTickerProviderStateMixin {
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