import 'package:get/get.dart';

class SearchControl extends GetxController {
  var searchType = 'المصممين'.obs; // أو 'التصاميم'
  var query = ''.obs;
  var results = [].obs;

  final List<String> searchTypes = ['المصممين', 'التصاميم'];

  // عندما تتغير الكلمة
  void onQueryChanged(String value) {
    query.value = value;
    _performSearch();
  }

  // عند تغيير نوع البحث
  void onTypeChanged(String newType) {
    searchType.value = newType;
    _performSearch();
  }

  Future<void> _performSearch() async {
    if (query.isEmpty) {
      results.clear();
      return;
    }

    if (searchType.value == 'المصممين') {
      results.value = await searchDesigners(query.value);
    } else if (searchType.value == 'التصاميم') {
      results.value = await searchDesigns(query.value);
    }
  }

  //  البحث عن المصممين
  Future<List<Map<String, dynamic>>> searchDesigners(String q) async {
    // مثال بسيط (محلي)، يمكنك استبداله بـ Firestore
    return [
      {'name': 'أحمد', 'specialization': 'شعارات'},
      {'name': 'سارة', 'specialization': 'واجهات تطبيق'},
    ]
        .where(
            (e) => e['name']!.contains(q) || e['specialization']!.contains(q))
        .toList();
  }

  //  البحث عن التصاميم
  Future<List<Map<String, dynamic>>> searchDesigns(String q) async {
    return [
      {'title': 'تصميم شعار ذهبي', 'category': 'شعارات'},
      {'title': 'واجهة تطبيق تسوق', 'category': 'واجهات'},
    ]
        .where((e) => e['title']!.contains(q) || e['category']!.contains(q))
        .toList();
  }
}
