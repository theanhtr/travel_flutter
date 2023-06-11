import 'package:flutter/material.dart';

class AlarmAnimation extends StatefulWidget {
  const AlarmAnimation({super.key, this.animated = true, this.size});

  final bool? animated;
  final double? size;

  @override
  State<AlarmAnimation> createState() => _AlarmAnimationState();
}

class _AlarmAnimationState extends State<AlarmAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  void _runAnimation() async {
    while (widget.animated == true) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _runAnimation();
    return RotationTransition(
      turns: Tween(begin: 0.0, end: -.1)
          .chain(CurveTween(curve: Curves.elasticIn))
          .animate(_animationController),
      child: Icon(
        Icons.notification_important_sharp,
        size: widget.size,
      ),
    );
  }
}
