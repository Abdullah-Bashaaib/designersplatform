import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrorHandler {
  static String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'صيغة البريد الإلكتروني غير صحيحة';
      case 'user-disabled':
        return 'تم تعطيل هذا الحساب';
      case 'user-not-found':
        return 'البريد الإلكتروني الذي أدخلته غير موجود';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'email-already-in-use':
        return 'هذا البريد مستخدم مسبقاً';
      case 'operation-not-allowed':
        return 'عملية تسجيل الدخول غير مسموحة حالياً';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً';
      case 'invalid-credential':
        return ' البيانات المدخلة غير صالحة أو منتهية';
      case 'network-request-failed':
        return 'خطأ في الشبكة، حاول مرة أخرى';
      default:
        return 'حدث خطأ غير متوقع، حاول لاحقاً';
    }
  }
}
