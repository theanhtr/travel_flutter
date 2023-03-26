import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckboxIcon extends StatefulWidget {
  CustomCheckboxIcon({
    Key? key,
    this.isChecked = false,
    this.width = 40.0,
    this.height = 40.0,
    this.color,
    this.onChanged,
    required this.selected,
    required this.unselected,
  }) : super(key: key);

  bool isChecked;
  final Widget selected;
  final Widget unselected;
  final double width;
  final double height;
  final Color? color;
  final Function(bool?)? onChanged;

  @override
  State<CustomCheckboxIcon> createState() => _CustomCheckboxIconState();
}

class _CustomCheckboxIconState extends State<CustomCheckboxIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => widget.isChecked = !widget.isChecked);
        widget.onChanged?.call(widget.isChecked);
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.isChecked
            ? widget.selected :
              widget.unselected,
      ),
    );
  }
}