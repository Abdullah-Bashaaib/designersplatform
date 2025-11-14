class AppFunctions {
  static List<String> generateKeywords(String text) {
    return text
        .trim()
        .toLowerCase()
        .split(RegExp(r'\s+')) // تقسيم على المسافات
        .toSet() // إزالة التكرار
        .toList();
  }
}
