import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/validators.dart';
import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('نسيت كلمة المرور'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header icon and text
                  Center(
                    child: Icon(
                      Icons.lock_reset,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'استعادة كلمة المرور',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      'ادخل بريدك الالكتروني وقم بالتحقق',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 32),

                  BuildTextField(
                    controller: _email,
                    label: 'البريد الالكتروني',
                    prefixIcon: Icons.email_outlined,
                    validator: Validators.email,
                  ),
                  SizedBox(height: 20),

                  // Submit button
                  SizedBox(
                    height: 50,
                    child: c.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final email = _email.text;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              // _isCodeSent
                              //     ? 'تحقق من الرمز'
                              //     :
                              'إرسال رمز التحقق',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
