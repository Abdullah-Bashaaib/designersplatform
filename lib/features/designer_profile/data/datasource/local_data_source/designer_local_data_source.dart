import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/key_app.dart';
import '../../models/designer_model.dart';

abstract class DesignerLocalDataSource {
  Future<Unit> initDesigner();
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
  Future<Unit> initDesigner() async {
    final user = sharedPreferences.getString(KeySharedPref
        .userKey); // بتجيب json حق المستخدم اللي انضافة من تسجيل الدخول
    final userJson = jsonDecode(user!);
    final designer = DesignerModel.fromJson({
      // تعطي بيانات افتراضية لانشاء json للمصمم تكملة لـ json المستخدم
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
    // فقط لو مش موجود مسبقًا
    final savedDesigner =
        sharedPreferences.getString(KeySharedPref.designerKey);
    List<dynamic> designerList = [];
    if (savedDesigner != null) {
      designerList = jsonDecode(savedDesigner);
    } else {
      if (!designerList // شوف قائمة المصممين
          .any((designer) => designer['user']['id'] == designer.user.id)) {
        // اذا لا يوجد هناك مصمم يمتلك نفس id نفذ الامر الذي تحت
        designerList.add(designer.toJson());
        await sharedPreferences.setString(
          KeySharedPref.designerKey,
          jsonEncode(designerList),
        );
      }
    }
    return unit;
  }

  @override
  Future<List<DesignerModel>> getAllDesigners() async {
    await initDesigner();
    final designerPref = sharedPreferences.getString(KeySharedPref.designerKey);
    if (designerPref == null) return [];

    final List<dynamic> jsonList = jsonDecode(designerPref);

    final designers =
        jsonList.map((json) => DesignerModel.fromJson(json)).toList();
    return designers;
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
