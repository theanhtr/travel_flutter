import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.infoList,
  });

  final String title;
  final List<String> infoList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding * 1.5),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: const Color.fromARGB(255, 231, 234, 244),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyles.defaultStyle.blackTextColor.bold
                  .setTextSize(kDefaultTextSize * 1.1)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                infoList.length,
                (index) => Column(
                      children: [
                        const SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Text(
                          infoList[index],
                          style: TextStyles.defaultStyle.blackTextColor.light
                              .setTextSize(kDefaultTextSize),
                        ),
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
