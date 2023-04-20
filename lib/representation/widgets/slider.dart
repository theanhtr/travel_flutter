import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';

// This Widget is the main application widget.

class MySliderApp extends StatefulWidget {
  /// initial selection for the slider
  final double initialFontSize;
  final double start;
  final double end;
  final String unit;
  final int? divisions;
  final Function(String, String)? getBudget;

  const MySliderApp(
      {super.key,
      required this.initialFontSize,
      required this.start,
      required this.end,
      required this.unit,
      this.divisions,
      this.getBudget});

  @override
  _MySliderAppState createState() => _MySliderAppState();
}

class _MySliderAppState extends State<MySliderApp> {
  /// current selection of the slider
  double start = 0;
  double end = 0;
  String unit = "";

  double _fontSize = 0;
  RangeValues _currentRangeValues = RangeValues(0, 10);
  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize;
    start = widget.start;
    end = widget.end;
    unit = widget.unit;
    _currentRangeValues = RangeValues(start, end);
  }

  // _MySliderAppState() {
  //   start = widget.start;
  //   end = widget.end;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 232),
        child: Expanded(
          child: RangeSlider(
            values: _currentRangeValues,
            min: widget.start,
            max: widget.end,
            divisions: widget.divisions ?? 10,
            activeColor: ColorPalette.primaryColor,
            inactiveColor: ColorPalette.cardBackgroundColor,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString() + widget.unit,
              _currentRangeValues.end.round().toString() + widget.unit,
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                widget.getBudget!(_currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString());
              });
            },
          ),
        ));
  }
}
