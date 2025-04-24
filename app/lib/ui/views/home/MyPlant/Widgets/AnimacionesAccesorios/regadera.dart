import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class Regadera extends StatefulWidget {
  const Regadera({Key? key}) : super(key: key);

  @override
  RegaderaState createState() => RegaderaState();
}

class RegaderaState extends State<Regadera> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duración de la animación
    );

    // Definir la animación de desplazamiento
    _animation = Tween<Offset>(
      begin: const Offset(0, 0), // Posición inicial
      end: const Offset(-.3, .8), // Posición final
    ).animate(_controller);

    // Iniciar la animación
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 190,
      top: 130,
      child: SlideTransition(
        position: _animation,
        child: const SvgPicture(
          AssetBytesLoader("assets/img/regadera.svg.vec"),
        ),
      ),
    );
  }
}
