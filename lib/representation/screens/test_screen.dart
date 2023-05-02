import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/representation/screens/admin/drawer_page_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/panelCenter_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  static const String routeName = '/admin_screen';
  @override
  State<TestScreen> createState() => _TestScreenState();
}

enum Section { HOME, ALL_HOTELS, ALL_USER }

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    Widget body;
    Section section = Section.HOME;

    return Scaffold(
      backgroundColor: ColorPalette.purpleDark,
      appBar: AppBar(
        title: Text("im admin"),
      ),
      body: Center(
        child: Text('Test screen'),
      ),
    );
  }
}
