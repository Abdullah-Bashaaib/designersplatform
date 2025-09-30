import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/key_app.dart';
import '../../models/designer_model.dart';

abstract class DesignerLocalDataSource {
  Future<List<DesignerModel>> getAllDesigners();
  Future<DesignerModel?> getData(String id);
  Future<Unit> updateData(DesignerModel designer);
  Future<Unit> deleteData(String id);
}

class DesignerLocalDataSourceImpBySharedPref
    implements DesignerLocalDataSource {
  final SharedPreferences sharedPreferences;

  DesignerLocalDataSourceImpBySharedPref({required this.sharedPreferences});

  @override
  Future<List<DesignerModel>> getAllDesigners() async {
    try {
      final userJsonString = sharedPreferences.getString(KeySharedPref.userKey);

      // حاول تهيئة المصمم إذا كان المستخدم موجود ودوره designer
      if (userJsonString != null) {
        final userJson = jsonDecode(userJsonString);
        log("-------------------------------------------------------${userJson['role']}");

        if (userJson['role'] == 'مصمم') {
          final designer = DesignerModel.fromJson({
            "user": userJson,
            "bio": "none",
            "number_bank": 0,
            "name_bank": "none",
            "specialization": "UI/UX",
            "is_available": 0,
            "reviewId": "none",
            "total_orders": 0,
            "works_count": 0,
          });

          final savedDesignerString =
              sharedPreferences.getString(KeySharedPref.designerKey);
          List<dynamic> designerList = savedDesignerString != null
              ? jsonDecode(savedDesignerString)
              : [];

          // إذا لم يكن المصمم موجود مسبقًا → أضفه
          final exists =
              designerList.any((d) => d['user']['id'] == designer.user.id);
          if (!exists) {
            designerList.add(designer.toJson());
            await sharedPreferences.setString(
                KeySharedPref.designerKey, jsonEncode(designerList));
          }
        }
      }

      // جلب قائمة المصممين الحالية أو قائمة فارغة إذا لم توجد
      final savedDesignerString =
          sharedPreferences.getString(KeySharedPref.designerKey);

      if (savedDesignerString == null || savedDesignerString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(savedDesignerString);
      final designers =
          jsonList.map((json) => DesignerModel.fromJson(json)).toList();

      return designers;
    } catch (e) {
      // لو حصل خطأ ترجع قائمة فارغة بدل crash
      return [];
    }
  }

  @override
  Future<DesignerModel?> getData(String id) async {
    final designers = await getAllDesigners();
    for (var designer in designers) {
      if (designer.user.id == id) return designer;
    }
    return null;
  }

  @override
  Future<Unit> updateData(DesignerModel updatedDesigner) async {
    // 1. استرجاع القائمة من SharedPreferences
    final designersPref =
        sharedPreferences.getString(KeySharedPref.designerKey);
    if (designersPref == null) return unit;

    // 2. تحويل JSON إلى List<DesignerModel>
    final List<dynamic> jsonDesigners = jsonDecode(designersPref);
    List<DesignerModel> designersList =
        jsonDesigners.map((item) => DesignerModel.fromJson(item)).toList();

    // 3. البحث عن المصمم باستخدام id
    final index =
        designersList.indexWhere((d) => d.user.id == updatedDesigner.user.id);

    if (index == -1) return unit; // المصمم غير موجود

    // 4. تحديث المصمم في القائمة
    designersList[index] = updatedDesigner;

    // 5. حفظ القائمة مرة ثانية في SharedPreferences
    final String encoded = jsonEncode(
      designersList.map((d) => d.toJson()).toList(),
    );
    await sharedPreferences.setString(KeySharedPref.designerKey, encoded);

    return unit;
  }

  @override
  Future<Unit> deleteData(String id) async {
    // 1. استرجاع القائمة من SharedPreferences
    final designersPref =
        sharedPreferences.getString(KeySharedPref.designerKey);
    if (designersPref == null) return unit;

    // 2. تحويل JSON إلى List<DesignerModel>
    final List<dynamic> jsonDesigners = jsonDecode(designersPref);
    List<DesignerModel> designersList =
        jsonDesigners.map((item) => DesignerModel.fromJson(item)).toList();

    // 3. حذف المصمم بالـ id
    designersList.removeWhere((d) => d.user.id == id);

    // 4. حفظ القائمة من جديد
    final String encoded =
        jsonEncode(designersList.map((d) => d.toJson()).toList());
    await sharedPreferences.setString(KeySharedPref.designerKey, encoded);

    return unit;
  }
}
