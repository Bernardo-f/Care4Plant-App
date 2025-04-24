import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final int progressValue;
  final int maxValue;

  const ProgressBar({super.key, this.progressValue = 1, this.maxValue = 6});

  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double previousProgress = 0;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
            begin: previousProgress,
            end: widget.progressValue.toDouble() / widget.maxValue.toDouble())
        .animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.progressValue != oldWidget.progressValue) {
      previousProgress = oldWidget.progressValue.toDouble() / widget.maxValue.toDouble();
      _animation = Tween<double>(
        begin: previousProgress,
        end: widget.progressValue.toDouble() / widget.maxValue.toDouble(),
      ).animate(_animationController);

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: MediaQuery.of(context).size.width * .8,
      child: Stack(children: [
        Container(
          height: 10,
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(112, 112, 112, .4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              return FractionallySizedBox(
                widthFactor: _animation.value,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(74, 146, 91, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            },
          ),
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          child: Text(
            '1',
            style: TextStyle(fontSize: 16, color: Color.fromRGBO(102, 101, 103, 1)),
          ),
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            '6',
            style: TextStyle(fontSize: 16, color: Color.fromRGBO(102, 101, 103, 1)),
          ),
        ),
      ]),
    );
  }
}
