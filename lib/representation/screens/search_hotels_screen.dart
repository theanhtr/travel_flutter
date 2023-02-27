import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/representation/screens/hotel_detail_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/hotel_card_widget.dart';

import '../../core/constants/dismention_constants.dart';

class SearchHotelsScreen extends StatefulWidget {
  const SearchHotelsScreen({super.key});

  static const String routeName = '/search_hotels_screen';

  @override
  State<SearchHotelsScreen> createState() => _SearchHotelsScreenState();
}

class _SearchHotelsScreenState extends State<SearchHotelsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Hotels',
      implementLeading: true,
      implementTrailing: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            HotelCardWidget(
              widthContainer: MediaQuery.of(context).size.width * 0.9,
              imageFilePath: AssetHelper.hotelImage1,
              name: 'Royal Palm Heritage',
              locationInfo: 'Purwokerto, Jateng',
              distanceInfo: '365 m',
              starInfo: 4.5,
              countReviews: 3123,
              priceInfo: 145,
              ontap: () async {
                await Navigator.pushNamed(context, HotelDetailScreen.routeName,
                    arguments: {
                      'name': 'Royal Palm Heritage',
                      'priceInfo': 145,
                      'locationInfo': 'Purwokerto, Jateng',
                      'distanceInfo': '365 m',
                      'starInfo': 4.5,
                      'countReviews': 3123,
                      'description':
                          'You will find every comfort because many of the services that the hotel offers for travellers and of course the hotel is very comfortable.',
                      'locationSpecial':
                          'Located in the famous neighborhood of Seoul, Grand Luxury is set in a building built in the 2010s.',
                      'services': <String>[
                        'Restaurant',
                        'Free Wifi',
                        'Currency Exchange',
                        'Private Pool',
                        '24-hour Font Desk'
                      ],
                    });
              },
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            HotelCardWidget(
              widthContainer: MediaQuery.of(context).size.width * 0.9,
              imageFilePath: AssetHelper.hotelImage2,
              name: 'Grand Luxury',
              locationInfo: 'Hanoi, Jateng',
              distanceInfo: '2.3 km',
              starInfo: 4.2,
              countReviews: 2623,
              priceInfo: 415,
              ontap: () {},
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            HotelCardWidget(
              widthContainer: MediaQuery.of(context).size.width * 0.9,
              imageFilePath: AssetHelper.hotelImage3,
              name: 'Royal Palm Heritage',
              locationInfo: 'TpHoChiMinh, Jateng',
              distanceInfo: '365 km',
              starInfo: 4.5,
              countReviews: 3123,
              priceInfo: 145,
              ontap: () {},
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
          ],
        ),
      ),
    );
  }
}
