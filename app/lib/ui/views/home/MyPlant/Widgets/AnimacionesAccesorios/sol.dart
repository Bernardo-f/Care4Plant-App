import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class Sol extends StatefulWidget {
  const Sol({Key? key}) : super(key: key);

  @override
  SolState createState() => SolState();
}

class SolState extends State<Sol> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 60,
      top: 100,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + .3 * _controller.value,
            child: child,
          );
        },
        child: GestureDetector(
          onTap: () {
            if (_controller.isAnimating) {
              _controller.stop();
            } else {
              _controller.forward();
            }
          },
          child: const SvgPicture(
            AssetBytesLoader("assets/img/sun.svg.vec"),
            width: 50,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
