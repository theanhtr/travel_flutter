import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateHelper {
  DateTime? startDate;
  DateTime? endDate;

  void convertSelectDateOnHotelBookingScreenToDateTime(String? dateString) {
    if (dateString == null) {
      return;
    }

    List<String> listDateString = dateString.split(' - ');
    this.endDate = DateFormat('dd MMM yyyy').parse(listDateString[1]);

    final endDate = this.endDate;
    if (endDate != null) {
      String startDateString =
          (listDateString[0] + ' ' + endDate.year.toString());
      this.startDate = DateFormat('dd MMM yyyy').parse(startDateString);
    }
  }

  String convertDateString(
      {required String dateString,
      String inputFormat = 'dd MMM yyyy',
      String outputFormat = 'MM/dd/yyyy'}) {
    DateFormat inputDateFormat = DateFormat(inputFormat);
    DateFormat outputDateFormat = DateFormat(outputFormat);

    DateTime date = inputDateFormat.parse(dateString);
    String formattedDateString = outputDateFormat.format(date);
    return formattedDateString;
  }

  DateTime? getStartDate() {
    return this.startDate;
  }

  DateTime? getEndDate() {
    return this.endDate;
  }
}
