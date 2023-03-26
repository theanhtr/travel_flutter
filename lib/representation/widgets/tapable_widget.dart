
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class TapableWidget extends StatefulWidget {
  const TapableWidget({Key? key, required this.child, this.onTap}) : super(key: key);

  final Widget child;
  final double scaleUp = 0.9;
  final Function()? onTap;

  @override
  State<TapableWidget> createState() => _TapableWidgetState();
}

class _TapableWidgetState extends State<TapableWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (widget.onTap),
      onTapDown: (TapDownDetails details){
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.reverse();
        });
      },
      child: ScaleTransition(
          scale: Tween<double>(
            begin: 1.0,
            end: widget.scaleUp,
          ).animate(_controller),
          child: widget.child
      ),
    );
  }
}

