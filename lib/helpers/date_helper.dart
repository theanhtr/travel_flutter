import 'package:intl/intl.dart';
import 'dart:io';

import 'package:logger/logger.dart';

class DateHelper {
  DateTime? startDate;
  DateTime? endDate;

  /* this function only use with input dateString have format  
  *         = 'dd MMM - dd MMM yyyy'
  *  example: '23 Feb - 29 Feb 2023'
  */
  void convertSelectDateOnHotelBookingScreenToDateTime(String? dateString) {
    if (dateString == null) {
      return;
    }

    List<String> listDateString = dateString.split(' - ');

    this.endDate =
        DateFormat('dd-MMM-yyyy').parse(listDateString[1].replaceAll(' ', '-'));

    final endDate = this.endDate;
    if (endDate != null) {
      String startDateString =
          (listDateString[0] + ' ' + endDate.year.toString())
              .replaceAll(' ', '-');
      
      this.startDate = DateFormat('dd-MMM-yyyy').parse(startDateString);
    }

    
  }

  DateTime? getStartDate() {
    return this.startDate;
  }

  DateTime? getEndDate() {
    return this.endDate;
  }
}
