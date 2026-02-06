import 'package:designers_platform/features/home/presentation/widget/active_orders_section.dart';
import 'package:designers_platform/features/home/presentation/widget/designer_header.dart';
import 'package:designers_platform/features/home/presentation/widget/reviews_section.dart';
import 'package:flutter/material.dart';

class BuildDesignerHome extends StatelessWidget {
  const BuildDesignerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DesignerHeader(),
            // StatsCardsSection(),
            ActiveOrdersSection(),
            // PortfolioPreviewSection(),
            ReviewsSection(),
          ],
        ),
      ),
    );
  }
}
