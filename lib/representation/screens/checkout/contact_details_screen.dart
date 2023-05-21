import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';

import '../../../core/utils/navigation_utils.dart';
import '../../../helpers/translations/localization_text.dart';
import '../../widgets/button_widget.dart';

class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({super.key});

  static const String routeName = '/contact_details';

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = NavigationUtils.getArguments(context);
    String name = args['name'];
    String phoneNumber = args['phone_number'];
    String email = args['email'];
    return AppBarContainer(
      implementLeading: true,
      resizeToAvoidBottomInset: true,
      titleString: LocalizationText.contactDetails,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              InputCard(
                  style: TypeInputCard.name,
                  value: name,
                  onchange: (value) {
                    name = value;
                  }),
              const SizedBox(
                height: 20,
              ),
              InputCard(
                  style: TypeInputCard.phoneNumber,
                  value: phoneNumber,
                  onchange: (value) {
                    phoneNumber = value;
                  }),
              const SizedBox(
                height: 20,
              ),
              InputCard(
                  style: TypeInputCard.email,
                  value: email,
                  onchange: (value) {
                    email = value;
                  }),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                title: LocalizationText.done,
                ontap: () {
                  Navigator.pop(
                    context,
                    [
                      name,
                      phoneNumber,
                      email,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
