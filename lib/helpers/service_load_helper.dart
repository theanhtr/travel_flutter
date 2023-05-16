import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';

class ServiceLoadHelper {
  static final Map<String, Map<String, dynamic>> listServices = {
    'Restaurant': {
      'icon': FontAwesomeIcons.utensils,
      'name': 'Restaurant',
      'primaryColor': const Color(0xff6155CC),
      'secondaryColor': const Color(0xff6155CC).withOpacity(0.2),
    },
    'Free wifi': {
      'icon': FontAwesomeIcons.wifi,
      'name': 'Free\nWifi',
      'primaryColor': const Color.fromARGB(255, 254, 94, 243),
      'secondaryColor':
          const Color.fromARGB(255, 254, 94, 243).withOpacity(0.2),
    },
    'Currency exchange': {
      'icon': FontAwesomeIcons.moneyBillTransfer,
      'name': 'Currency\nExchange',
      'primaryColor': const Color(0xffF97674),
      'secondaryColor': const Color(0xffF97674).withOpacity(0.2)
    },
    '24-hour font desk': {
      'icon': FontAwesomeIcons.check,
      'name': '24-hour\nFont Desk',
      'primaryColor': const Color(0xff34C9BD),
      'secondaryColor': const Color(0xff34C9BD).withOpacity(0.2)
    },
    'Private pool': {
      'icon': FontAwesomeIcons.personSwimming,
      'name': 'Private\nPool',
      'primaryColor': const Color.fromARGB(255, 52, 74, 201),
      'secondaryColor': const Color.fromARGB(255, 52, 74, 201).withOpacity(0.2),
    },
    'Non refunable': {
      'icon': FontAwesomeIcons.creativeCommonsNcEu,
      'name': 'Non\nRefundable',
      'primaryColor': const Color(0xffFE9C5E),
      'secondaryColor': const Color(0xffFE9C5E).withOpacity(0.2)
    },
    'Non smoking': {
      'icon': FontAwesomeIcons.banSmoking,
      'name': 'Non\nSmoking',
      'primaryColor': const Color(0xff3EC8BC),
      'secondaryColor': const Color(0xff3EC8BC).withOpacity(0.2)
    },
    'Free breakfast': {
      'icon': FontAwesomeIcons.utensils,
      'name': 'Free\nBreakfast',
      'primaryColor': const Color(0xffF77777),
      'secondaryColor': const Color(0xffF77777).withOpacity(0.2)
    },
    'Digital TV': {
      'icon': FontAwesomeIcons.tv,
      'name': 'Digital\nTV',
      'primaryColor': const Color(0xffF77777),
      'secondaryColor': const Color(0xffF77777).withOpacity(0.2)
    },
    'Parking Area': {
      'icon': FontAwesomeIcons.squareParking,
      'name': 'Parking\nArea',
      'primaryColor': const Color(0xffF77777),
      'secondaryColor': const Color(0xffF77777).withOpacity(0.2)
    },
    'Swimming Pool': {
      'icon': FontAwesomeIcons.waterLadder,
      'name': 'Swimming\nPool',
      'primaryColor': const Color(0xffF77777),
      'secondaryColor': const Color(0xffF77777).withOpacity(0.2)
    },
    'Car Rental': {
      'icon': FontAwesomeIcons.carSide,
      'name': 'Car\nRental',
      'primaryColor': const Color(0xffF77777),
      'secondaryColor': const Color(0xffF77777).withOpacity(0.2)
    },
    'More': {
      'icon': FontAwesomeIcons.ellipsis,
      'name': 'More',
      'primaryColor': const Color(0xff2D3143),
      'secondaryColor': const Color(0xff2D3143).withOpacity(0.2)
    },
    'Error': {
      'icon': FontAwesomeIcons.exclamation,
      'name': 'Error',
      'primaryColor': const Color(0xff2D3143),
      'secondaryColor': const Color(0xff2D3143).withOpacity(0.2)
    },
    'Non refundable': {
      'icon': FontAwesomeIcons.exclamation,
      'name': 'Error',
      'primaryColor': const Color(0xff2D3143),
      'secondaryColor': const Color(0xff2D3143).withOpacity(0.2)
    },
    'Baggage': {
      'icon': FontAwesomeIcons.exclamation,
      'name': 'Error',
      'primaryColor': const Color(0xff2D3143),
      'secondaryColor': const Color(0xff2D3143).withOpacity(0.2)
    }
  };

  static Widget serviceWidget(String nameService) {
    return Expanded(
        flex: 2,
        child: ItemText(
          icon: listServices[nameService]!['icon'] ??
              listServices['Error']!['icon'],
          text: listServices[nameService]!['name'] ??
              listServices['Error']!['name'],
          sizeText: kDefaultTextSize / 1.8,
          sizeItem: kDefaultIconSize / 2,
          primaryColor: listServices[nameService]!['primaryColor'] ??
              listServices['Error']!['primaryColor'],
          secondaryColor: listServices[nameService]!['secondaryColor'] ??
              listServices['Error']!['secondaryColor'],
        ));
  }
}
