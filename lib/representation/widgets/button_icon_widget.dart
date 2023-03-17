import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';

import '../../core/constants/textstyle_constants.dart';

class ButtonIconWidget extends StatefulWidget {
  const ButtonIconWidget(
      {super.key,
      required this.title,
      this.ontap,
      required this.backgroundColor,
      required this.textColor,
      required this.icon});

  final double scaleUp = 0.7;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Widget icon;
  final Function()? ontap;

  @override
  State<ButtonIconWidget> createState() => _ButtonIconWidgetState();
}

class _ButtonIconWidgetState extends State<ButtonIconWidget> with SingleTickerProviderStateMixin {
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
      onTap: widget.ontap,
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
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMediumPadding),
            color: widget.backgroundColor,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(
                width: kDefaultPadding / 2,
              ),
              Text(
                widget.title,
                style: TextStyles.defaultStyle.bold
                    .setColor(widget.textColor)
                    .setTextSize(kDefaultTextSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
