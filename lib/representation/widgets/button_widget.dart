import 'package:flutter/material.dart';
import '../../core/constants/color_palatte.dart';
import '../../core/constants/dismention_constants.dart';
import '../../core/constants/textstyle_constants.dart';

class ButtonWidget extends StatefulWidget {
  final double scaleUp = 0.7;
  final String title;
  final Function()? ontap;

  const ButtonWidget({super.key, required this.title, this.ontap});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (widget.ontap),
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
        child: Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kMediumPadding),
                  gradient: Gradients.defaultGradientBackground,
                ),
                alignment: Alignment.center,
                child: Text(widget.title, style: TextStyles.defaultStyle.bold.whiteTextColor)
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
