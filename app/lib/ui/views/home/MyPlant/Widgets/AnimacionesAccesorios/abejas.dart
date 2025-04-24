import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class Abeja1 extends StatefulWidget {
  const Abeja1({Key? key}) : super(key: key);

  @override
  AbejasState createState() => AbejasState();
}

class AbejasState extends State<Abeja1> with TickerProviderStateMixin {
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

  List<Widget> animatedAbejas() {
    List<Widget> abejas = [];
    abejas.add(Positioned(
      left: 50,
      top: 150,
      child: SlideTransition(
        position: _animation,
        child: const SvgPicture(
          AssetBytesLoader("assets/img/abeja.svg.vec"),
        ),
      ),
    ));
    return abejas;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 50,
      top: 150,
      child: SlideTransition(
        position: _animation,
        child: const SvgPicture(
          AssetBytesLoader("assets/img/abeja.svg.vec"),
        ),
      ),
    );
  }
}

class Abeja2 extends StatefulWidget {
  const Abeja2({Key? key}) : super(key: key);

  @override
  AbejasState2 createState() => AbejasState2();
}

class AbejasState2 extends State<Abeja2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 800000), // Duración de la animación
    );

    // Definir la animación de desplazamiento
    _animation = Tween<Offset>(
      begin: const Offset(0, 0), // Posición inicial
      end: const Offset(.5, .3), // Posición final
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
      left: 160,
      top: 120,
      child: SlideTransition(
        position: _animation,
        child: const SvgPicture(
          AssetBytesLoader("assets/img/abeja.svg.vec"),
          width: 25,
        ),
      ),
    );
  }
}

class Abeja3 extends StatefulWidget {
  const Abeja3({Key? key}) : super(key: key);

  @override
  Abeja3State createState() => Abeja3State();
}

class Abeja3State extends State<Abeja3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 1000000), // Duración de la animación
    );

    // Definir la animación de desplazamiento
    _animation = Tween<Offset>(
      begin: const Offset(0, 0), // Posición inicial
      end: const Offset(.5, .3), // Posición final
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
      top: 180,
      child: SlideTransition(
        position: _animation,
        child: const SvgPicture(
          AssetBytesLoader("assets/img/abeja2.svg.vec"),
          width: 40,
        ),
      ),
    );
  }
}
