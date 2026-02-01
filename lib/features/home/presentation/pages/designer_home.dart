import 'package:designers_platform/features/home/presentation/widget/active_orders_section.dart';
import 'package:designers_platform/features/home/presentation/widget/designer_bottom_nav.dart';
import 'package:designers_platform/features/home/presentation/widget/designer_fab.dart';
import 'package:designers_platform/features/home/presentation/widget/designer_header.dart';
import 'package:designers_platform/features/home/presentation/widget/portfolio_preview_section.dart';
import 'package:designers_platform/features/home/presentation/widget/reviews_section.dart';
import 'package:designers_platform/features/home/presentation/widget/stats_cards_section.dart';
import 'package:flutter/material.dart';

class DesignerHome extends StatelessWidget {
  const DesignerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DesignerHeader(),
              StatsCardsSection(),
              ActiveOrdersSection(),
              PortfolioPreviewSection(),
              ReviewsSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: DesignerFAB(),
      bottomNavigationBar: DesignerBottomNav(),
    );
  }
}
