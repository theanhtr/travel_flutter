import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/date_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/out_button_widget.dart';

class SelectDateScreen extends StatelessWidget {
  SelectDateScreen({super.key, this.rangeStartDate, this.rangeEndDate});

  static String routeName = '/select_date_screen';

  DateTime? rangeStartDate;
  DateTime? rangeEndDate;
  DateTime? oldRangeStartDate;
  DateTime? oldRangeEndDate;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    String? oldDate = args['oldDate'];
    DateHelper dateHelper = DateHelper();
    dateHelper.convertSelectDateOnHotelBookingScreenToDateTime(oldDate);
    oldRangeStartDate = dateHelper.getStartDate() ?? DateTime.now();
    oldRangeEndDate = dateHelper.getEndDate() ?? DateTime.now();
    rangeStartDate = oldRangeStartDate;
    rangeEndDate = oldRangeEndDate;

    return AppBarContainer(
      implementLeading: true,
      titleString: LocalizationText.selectDate,
      child: Column(
        children: [
          const SizedBox(
            height: kMediumPadding * 1.5,
          ),
          SfDateRangePicker(
            initialSelectedRange: PickerDateRange(
              oldRangeStartDate,
              oldRangeEndDate,
            ),
            toggleDaySelection: true,
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.range,
            enablePastDates: false,
            headerHeight: 80,
            headerStyle: const DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: kDefaultTextSize,
                  color: ColorPalette.text1Color,
                )),
            monthViewSettings: const DateRangePickerMonthViewSettings(
              weekendDays: [7, 6],
            ),
            startRangeSelectionColor: ColorPalette.yellowColor,
            endRangeSelectionColor: ColorPalette.yellowColor,
            rangeSelectionColor: ColorPalette.yellowColor.withOpacity(0.2),
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is PickerDateRange) {
                rangeStartDate = args.value.startDate;
                rangeEndDate = args.value.endDate;
              } else {
                rangeStartDate = null;
                rangeEndDate = null;
              }
            },
          ),
          ButtonWidget(
            title: LocalizationText.select,
            ontap: () {
              Navigator.of(context).pop([rangeStartDate, rangeEndDate]);
            },
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          OutButtonWidget(
            title: LocalizationText.cancel,
            ontap: () {
              Navigator.of(context).pop([null]);
            },
          )
        ],
      ),
    );
  }
}
