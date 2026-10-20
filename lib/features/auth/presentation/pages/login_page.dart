import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/widget/validators.dart';
import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'الرجاء تسجيل الدخول باستخدام الحساب المسجل',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      BuildTextField(
                        controller: _emailController,
                        hintText: 'أدخل بريدك الإلكتروني',
                        prefixIcon: FontAwesomeIcons.envelope,
                        label: 'البريد الإلكتروني',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                      ),
                      SizedBox(height: 24.h),
                      Obx(
                        () => BuildTextField(
                          controller: _passwordController,
                          hintText: 'قم بإنشاء كلمة المرور الخاصة بك',
                          prefixIcon: Icons.lock_outlined,
                          label: 'كلمة المرور',
                          obscureText: c.obscureText.value,
                          validator: Validators.password,
                          suffixIcon: IconButton(
                            icon: Icon(
                              c.obscureText.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              c.obscureText.value = !c.obscureText.value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => ForgotPasswordScreen());
                          },
                          child: Text(
                            'هل نسيت كلمة المرور',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: Obx(
                          () => c.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final email = _emailController.text;
                                      final password = _passwordController.text;
                                      c.login(email, password);
                                    }
                                  },
                                  style: AppStyles.primaryButtonStyle,
                                  child: Text('تسجيل الدخول',
                                      style: AppStyles.bodyMedium),
                                ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      // Center(
                      //   child: Text('أو استخدم طريقة اخرى',
                      //       style: AppStyles.bodyMedium),
                      // ),
                      // const SizedBox(height: 24),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: OutlinedButton.icon(
                      //         onPressed: () {
                      //           // Handle Google sign in
                      //         },
                      //         icon: const Icon(Icons.abc),
                      //         // Image.asset(
                      //         //   'assets/images/2.png',
                      //         //   width: 20,
                      //         //   height: 20,
                      //         // ),
                      //         label: const Text(
                      //           'سجل الدخول باستخدام قوقل',
                      //           style: TextStyle(
                      //             color: Colors.black87,
                      //             fontSize: 14,
                      //           ),
                      //         ),
                      //         style: OutlinedButton.styleFrom(
                      //           padding:
                      //               const EdgeInsets.symmetric(vertical: 16),
                      //           side: BorderSide(color: Colors.grey[300]!),
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 16),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: OutlinedButton.icon(
                      //         onPressed: () {
                      //           // Handle Facebook sign in
                      //         },
                      //         icon: const Icon(
                      //           Icons.facebook,
                      //           color: Color(0xFF1877F2),
                      //           size: 20,
                      //         ),
                      //         label: const Text(
                      //           'سجل الدخول باستخدام فيسبوك',
                      //           style: TextStyle(
                      //             fontSize: 14,
                      //           ),
                      //         ),
                      //         style: OutlinedButton.styleFrom(
                      //           padding:
                      //               const EdgeInsets.symmetric(vertical: 16),
                      //           side: BorderSide(color: Colors.grey[300]!),
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
