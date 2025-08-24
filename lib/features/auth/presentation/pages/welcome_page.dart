import 'package:designers_platform/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  final emilC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Various Collections Of The Latest Products',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam cursus vestibulum.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Get.to(CreateAccountScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5D5FEF),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 15.0),
              TextButton(
                onPressed: () {
                  // Navigate to login screen
                },
                child: Text(
                  'Already Have an Account?',
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
