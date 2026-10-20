import 'package:intl/intl.dart';

String formatStyleDate(DateTime date, String locale) {
  final now = DateTime.now();

  // توحيد التواريخ (بدون وقت) لسهولة المقارنة
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final orderDate = DateTime(date.year, date.month, date.day);

  if (orderDate == today) {
    // 1. إذا كان اليوم: اعرض الوقت فقط
    return DateFormat.jm(locale).format(date); // .jm()  =>  "10:30 ص"
  } else if (orderDate == yesterday) {
    // 2. إذا كان الأمس
    return 'الأمس';
  } else if (now.year == date.year) {
    // 3. إذا كان هذه السنة (شكل أفضل من d/M)
    return DateFormat('d MMM', locale).format(date); //  =>  "30 أكتوبر"
  } else {
    // 4. إذا كان سنة ماضية
    return DateFormat('d/M/y', locale).format(date); //  =>  "30/10/2024"
  }
}
