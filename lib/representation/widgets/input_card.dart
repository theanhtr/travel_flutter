import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';

class InputCard extends StatefulWidget {
  InputCard({
    super.key,
    required this.style,
    required this.onchange,
    this.value,
  });

  final String style;
  final Function onchange;
  String? value = "";

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  dynamic value;
  late final TextEditingController? _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    String? style = widget.style;
    if (widget.value != null) {
      _textController?.text = widget.value ?? "";
    }
    bool showPassword = false;

    Widget widgetToDisplay;

    switch (style) {
      case 'First Name':
      case 'Last Name':
      case 'Email':
        widgetToDisplay = TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: style,
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;
      case 'Password':
        widgetToDisplay = StatefulBuilder(builder: (context, setState) {
          return TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: style,
              border: InputBorder.none,
              labelStyle: TextStyles.defaultStyle.blackTextColor.light
                  .setTextSize(kDefaultTextSize / 1.1),
              suffixIcon: IconButton(
                onPressed: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                icon: Icon(showPassword
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye),
              ),
            ),
            style: TextStyles.defaultStyle.blackTextColor.bold
                .setTextSize(kDefaultTextSize * 1.2),
            onChanged: (String query) {
              value = _textController?.text;
              widget.onchange(value);
            },
            obscureText: showPassword,
          );
        });
        break;
      case 'Password Confirm':
        widgetToDisplay = StatefulBuilder(builder: (context, setState) {
          return TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: style,
              border: InputBorder.none,
              labelStyle: TextStyles.defaultStyle.blackTextColor.light
                  .setTextSize(kDefaultTextSize / 1.1),
              suffixIcon: IconButton(
                onPressed: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                icon: Icon(showPassword
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye),
              ),
            ),
            style: TextStyles.defaultStyle.blackTextColor.bold
                .setTextSize(kDefaultTextSize * 1.2),
            onChanged: (String query) {
              value = _textController?.text;
              widget.onchange(value);
            },
            obscureText: showPassword,
          );
        });
        break;
      case 'Phone Number':
        widgetToDisplay = TextField(
          keyboardType: TextInputType.number,
          controller: _textController,
          decoration: InputDecoration(
            labelText: style,
            border: InputBorder.none,
            labelStyle: TextStyles.defaultStyle.blackTextColor.light
                .setTextSize(kDefaultTextSize / 1.1),
          ),
          style: TextStyles.defaultStyle.blackTextColor.bold
              .setTextSize(kDefaultTextSize * 1.2),
          onChanged: (String query) {
            value = _textController?.text;
            widget.onchange(value);
          },
        );
        break;
      default:
        widgetToDisplay = Text('Other');
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 1.4, vertical: kDefaultPadding / 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: ColorPalette.cardBackgroundColor,
      ),
      child: widgetToDisplay,
    );
  }
}
