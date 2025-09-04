import 'package:designers_platform/core/utils/app_image.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditClientProfileScreen extends StatelessWidget {
  const EditClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ClientProfileController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(AppImage.image1),
                  // Or use NetworkImage for online images
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Username Field

            BuildTextField(
              controller: c.userName,
              label: 'Username',
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: 20),

            // Email/Phone Field
            BuildTextField(
              controller: c.email,
              label: 'Email or Phone Number',
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: 20),

            // Account Linked With
            _buildAccountLinked(),

            SizedBox(height: 40),

            // Save Changes Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5B4FCF), // Purple color
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountLinked() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Liked With',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Row(
            children: [
              // Image.asset(
              //   , // Add Google logo asset
              //   width: 24,
              //   height: 24,
              // ),
              SizedBox(width: 16),
              Text(
                'Google',
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Icon(
                Icons.link,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
