import 'dart:convert';

import 'package:designers_platform/core/utils/key_app.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_source/designer_local_data_source.dart';
// استبدل بالمسارات الصحيحة عندك
import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DesignerLocalDataSource - getData', () {
    late SharedPreferences sharedPreferences;
    late DesignerLocalDataSourceImpBySharedPref dataSource;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      dataSource = DesignerLocalDataSourceImpBySharedPref(
          sharedPreferences: sharedPreferences);
    });

    test('should return null if no designers exist', () async {
      // Arrange: SharedPreferences فارغ
      // Act
      final designer = await dataSource.getData("123");

      // Assert
      expect(designer, null);
    });

    test('should return designer if exists', () async {
      // Arrange
      final userJson = {
        "id": "123",
        "name": "Designer User",
        "email": "designer@test.com",
        "password": "123456",
        "role": "designer",
      };
      final designerModel = DesignerModel.fromJson({
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

      await sharedPreferences.setString(
          KeySharedPref.designerKey, jsonEncode([designerModel.toJson()]));

      // Act
      final result = await dataSource.getData("123");

      // Assert
      expect(result, isA<DesignerModel>());
      expect(result?.id, "123");
    });

    test('should return null if designer with id does not exist', () async {
      // Arrange
      final userJson = {
        "id": "123",
        "name": "Designer User",
        "email": "designer@test.com",
        "password": "123456",
        "role": "designer",
      };
      final designerModel = DesignerModel.fromJson({
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

      await sharedPreferences.setString(
          KeySharedPref.designerKey, jsonEncode([designerModel.toJson()]));

      // Act
      final result = await dataSource.getData("999"); // id غير موجود

      // Assert
      expect(result, null);
    });
  });
}
