import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:designers_platform/core/widget/build_dropdown_button.dart';
import 'package:designers_platform/core/widget/build_social_sign_in_button.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../domain/entities/user.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? selectedAccountType;

  final List<String> accountTypes = ["عميل", "مصمم"];

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'إنشاء حساب',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'إبدء رحلتك في عالم التصميم عبر انشاء حساب',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                BuildTextField(
                  controller: _usernameController,
                  hintText: 'أدخل اسم المستخدم',
                  prefixIcon: FontAwesomeIcons.user,
                  label: 'اسم المستخدم',
                ),
                const SizedBox(height: 16),
                BuildTextField(
                  controller: _emailController,
                  hintText: 'أدخل الايميل او رقم الهاتف',
                  prefixIcon: FontAwesomeIcons.envelope,
                  label: 'الايميل او رقم الهاتف',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => BuildTextField(
                    controller: _passwordController,
                    hintText: 'أدخل كلمة المرور',
                    prefixIcon: Icons.lock_outlined,
                    label: 'كلمة المرور',
                    obscureText: c.obscureText.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        c.obscureText.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        c.obscureText.value = !c.obscureText.value;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => BuildDropdownButton(
                      selectedAccountType: c.role.value ?? accountTypes.first,
                      accountTypes: accountTypes,
                      label: 'نوع الحساب'),
                ),
                const SizedBox(height: 24),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: c.isLoading.value
                        ? Center(child: const CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                User user = User(
                                    name: _usernameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    role: c.role.value!);
                                c.signUp(user);
                              }
                            },
                            style: AppStyles.primaryButtonStyle,
                            child: const Text(
                              'إنشاء الحساب',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'أو استخدم طريقة اخرى',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BuildSocialSignInButton(
                  onPressed: () {},
                  text: 'التسجيل بواسطة قوقل',
                  icon: Icons.g_mobiledata,
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                ),
                const SizedBox(height: 12),
                BuildSocialSignInButton(
                  onPressed: () {},
                  text: 'التسجيل بواسطة فيسبوك',
                  icon: Icons.facebook,
                  backgroundColor: const Color(0xFF1877F2),
                  textColor: Colors.white,
                ),
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    width: 64,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
