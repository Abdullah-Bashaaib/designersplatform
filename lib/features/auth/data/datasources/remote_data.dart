import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/core/error/supabase_error_handler.dart';
import 'package:designers_platform/features/auth/data/models/user_model.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteData {
  Future<UserModel?> checkAccountInRemote(String email, String password);
  Future<UserEntity> signUp(UserEntity user, String password);
  Future<void> deleteAccount();
  Future<bool> forgetPassword(String email);
}

class RemoteDataSource implements RemoteData {
  final SupabaseClient supabase;

  RemoteDataSource(this.supabase);

  @override
  Future<UserModel?> checkAccountInRemote(String email, String password) async {
    try {
      /// تسجيل الدخول
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) return null;

      /// جلب بيانات user من جدول users
      final result = await supabase
          .from('users')
          .select()
          .eq('email', email)
          .limit(1)
          .single();

      return UserModel.fromJson(result);
    } on AuthException catch (e) {
      throw ServerException(
          SupabaseAuthErrorHandler.getErrorMessage(e.message));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserEntity> signUp(UserEntity user, String password) async {
    try {
      final authRes = await supabase.auth.signUp(
        email: user.email,
        password: password,
      );

      if (authRes.user == null) {
        throw ServerException("تعذر إنشاء الحساب");
      }

      /// تجهيز الموديل
      UserModel userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        role: user.role,
        keywords: user.keywords,
      );

      /// تخزين بيانات المستخدم داخل جدول users
      await supabase.from('users').insert(userModel.toMap());

      return user;
    } on AuthException catch (e) {
      throw ServerException(
          SupabaseAuthErrorHandler.getErrorMessage(e.message));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final userId = CurrentUser.currentUser!.id;

      /// حذف من جدول users
      await supabase.from('users').delete().eq('id', userId);

      /// حذف حساب auth
      await supabase.auth.admin.deleteUser(userId);
    } on AuthException catch (e) {
      throw ServerException(
          SupabaseAuthErrorHandler.getErrorMessage(e.message));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> forgetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      return true;
    } on AuthException catch (e) {
      throw ServerException(
          SupabaseAuthErrorHandler.getErrorMessage(e.message));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
