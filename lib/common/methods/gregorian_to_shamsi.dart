import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian/persian.dart';

String gregorianToShamsi(String date) {
  if (date != '') {
    final dateTime = DateTime.parse(date);
    final jalaliDate = Jalali.fromDateTime(dateTime);
    final hour = jalaliDate.hour.toString().withPersianNumbers();
    final minute = jalaliDate.minute.toString().withPersianNumbers();
    final f = jalaliDate.formatter;

    final String time =
        '${f.wN.withPersianNumbers()} ${f.d.withPersianNumbers()} ${f.mN.withPersianNumbers()} ${f.yyyy.withPersianNumbers()} ساعت $hour و $minute دقیقه';

    return time;
  } else {
    return '';
  }
}

String gregorainToShamsiDateOnly(String date) {
  if (date != '') {
    final dateTime = DateTime.parse(date);
    final jalaliDate = Jalali.fromDateTime(dateTime);
    final f = jalaliDate.formatter;
    final String dateOnly =
        '${f.wN.withPersianNumbers()} ${f.d.withPersianNumbers()} ${f.mN.withPersianNumbers()} ${f.yyyy.withPersianNumbers()}';
    return dateOnly;
  } else {
    return '';
  }
}

String gregorianToShamsiDateNumber(String date) {
  if (date != '') {
    final dateTime = DateTime.parse(date);
    final jalaliDate = Jalali.fromDateTime(dateTime);
    final f = jalaliDate.formatter;
    final String dateNumber =
        '${f.yy.withPersianNumbers()}/${f.m.withPersianNumbers()}/${f.d.withPersianNumbers()}';
    return dateNumber;
  } else {
    return '';
  }
}

String gregorianToShamsiTimeOnly(String date) {
  if (date != '') {
    final dateTime = DateTime.parse(date);
    final jalaliDate = Jalali.fromDateTime(dateTime);
    final hour = jalaliDate.hour.toString().withPersianNumbers();
    final minute = jalaliDate.minute.toString().withPersianNumbers();
    final f = jalaliDate.formatter;

    final String timeOnly = 'ساعت $hour و $minute دقیقه';

    return timeOnly;
  } else {
    return '';
  }
}
