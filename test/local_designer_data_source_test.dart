// import 'package:dartz/dartz.dart';
// import 'package:designers_platform/core/errors/failures.dart';
// // استبدل بالمسارات الفعلية عندك
// import 'package:designers_platform/core/utils/key_app.dart';
// import 'package:designers_platform/features/auth/domain/entities/user.dart';
// import 'package:designers_platform/features/auth/domain/usecases/get_profile_usecase.dart';
// import 'package:designers_platform/features/auth/presentation/controllers/profile_controller.dart';
// import 'package:designers_platform/features/auth/presentation/pages/welcome_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'get_data_designer_profile_test.mocks.dart';
//
// @GenerateMocks([GetProfileUseCase])
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   late MockGetProfileUseCase mockGetProfileUseCase;
//   late ProfileController controller;
//   late SharedPreferences sharedPreferences;
//
//   setUp(() async {
//     SharedPreferences.setMockInitialValues(
//         {KeySharedPref.kUserId: "123"}); // إعداد id المستخدم
//     sharedPreferences = await SharedPreferences.getInstance();
//
//     mockGetProfileUseCase = MockGetProfileUseCase();
//     controller = ProfileController(
//       getProfileUseCase: mockGetProfileUseCase,
//       sharedPreferences: sharedPreferences,
//     );
//   });
//
//   test('should show error and navigate to WelcomePage when failure', () async {
//     // Arrange
//     when(mockGetProfileUseCase.call("123"))
//         .thenAnswer((_) async => Left(ServerFailure(message: "server error")));
//
//     // Act
//     await controller.getDataDesignerProfile();
//
//     // Assert
//     expect(controller.isLoading.value, false);
//     verify(mockGetProfileUseCase.call("123")).called(1);
//     // هنا ممكن تعمل assert على الـ navigation لو حابب
//   });
//
//   test('should load user successfully when success', () async {
//     // Arrange
//     const user = User(
//       id: "123",
//       name: "Test User",
//       email: "test@test.com",
//       password: "123456",
//       role: "designer",
//     );
//     when(mockGetProfileUseCase.call("123"))
//         .thenAnswer((_) async => const Right(user));
//
//     // Act
//     await controller.getDataDesignerProfile();
//
//     // Assert
//     expect(controller.isLoading.value, false);
//     verify(mockGetProfileUseCase.call("123")).called(1);
//     // هنا ممكن تتحقق من أن user.name تم حفظه في المتغير nameUser إذا فعلته
//   });
// }
