class SupabaseAuthErrorHandler {
  static String getErrorMessage(String message) {
    if (message.contains("Invalid login credentials")) {
      return "البريد أو كلمة المرور غير صحيحة";
    }

    if (message.contains("Email not confirmed")) {
      return "يجب تأكيد البريد الإلكتروني قبل تسجيل الدخول";
    }

    if (message.contains("User already registered")) {
      return "هذا البريد مستخدم مسبقاً";
    }

    if (message.contains("Password should be at least")) {
      return "كلمة المرور ضعيفة جداً";
    }

    if (message.contains("invalid email")) {
      return "صيغة البريد الإلكتروني غير صحيحة";
    }

    if (message.contains("network")) {
      return "خطأ في الشبكة، حاول مرة أخرى";
    }

    // Default
    return "حدث خطأ غير متوقع، حاول لاحقاً";
  }
}
