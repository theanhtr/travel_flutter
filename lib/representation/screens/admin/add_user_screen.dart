import 'package:flutter/widgets.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  String email = "";
  String roleId = "";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: kDefaultPadding,
        ),
        StatefulBuilder(
          builder: (context, setState) => InputCard(
            style: TypeInputCard.email,
            onchange: (String value) {
              email = value;
            },
            value: email,
          ),
        ),
        const SizedBox(
          height: kDefaultPadding * 2,
        ),
        StatefulBuilder(
          builder: (context, setState) => InputCard(
              style: TypeInputCard.roleId,
              onchange: (String value) {
                roleId = value;
              },
              value: roleId),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        ButtonWidget(title: 'Create user', ontap: () {}),
      ]),
    );
  }
}
