import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/widget/custom_text.dart';

class CompletionPage extends StatelessWidget {
  const CompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
                  .withAlpha(200) // Light mode: white with slight transparency
              : Colors.black.withAlpha(200),
          title: CustomText(text: 'انجازاتي'),
        ),
        body: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return Card(
                color: Theme.of(context).primaryColor,
                child: ListTile(
                  leading: CustomText(text: 'text'),
                ),
              );
            }));
  }
}
