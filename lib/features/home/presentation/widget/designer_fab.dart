import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignerFAB extends StatelessWidget {
  const DesignerFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showActions(context),
      backgroundColor: Colors.deepPurple,
      child: const Icon(Icons.add, size: 28),
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionItem(
                icon: Icons.add_photo_alternate,
                title: 'إضافة عمل جديد',
                onTap: () {},
              ),
              _ActionItem(
                icon: Icons.assignment,
                title: 'إنشاء طلب مخصص',
                onTap: () {},
              ),
              _ActionItem(
                icon: Icons.bar_chart,
                title: 'عرض التقارير',
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22.r,
        backgroundColor: Colors.deepPurple.withOpacity(0.15),
        child: Icon(icon, color: Colors.deepPurple),
      ),
      title: Text(title, style: TextStyle(fontSize: 15.sp)),
      onTap: onTap,
    );
  }
}
