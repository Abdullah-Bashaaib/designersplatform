import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/auth/presentation/pages/login_page.dart';
import 'package:designers_platform/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_image.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> images = [
    AppImage.image1,
    AppImage.image2,
    AppImage.image3,
  ];

  final List<String> texts = [
    'أهلا وسهلا بك في منصة المصممين',
    'ابحث عن أفضل المصممين وابدأ مشروعك',
    'انطلق وشارك إبداعاتك مع الآخرين',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26.0),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentPage == index ? 12.0 : 8.0,
                    height: _currentPage == index ? 12.0 : 8.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.black
                          : Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                texts[_currentPage],
                style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: "adobe_arabic",
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const CreateAccountScreen());
                },
                style: AppStyles.primaryButtonStyle,
                child: const Text(
                  'إنشاء حساب',
                ),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                onPressed: () {
                  Get.to(const LoginScreen());
                },
                child: const Text(
                  'هل تمتلك حسابا بالفعل؟',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
