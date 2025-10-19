import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:designers_platform/features/customer_profile/other.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/profile_screen.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  final Other o = Other();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDesigners();
  }

  Future<void> _loadDesigners() async {
    // نحاكي التحميل
    await Future.delayed(const Duration(seconds: 3));
    await o.getDesigners();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final designerList = o.designerList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Other'),
      ),
      body: Skeletonizer(
        enabled: _loading, // ✨ لإضافة حركة وميض
        child: ListView.builder(
          itemCount: _loading ? 6 : designerList.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, i) {
            // في حالة التحميل نعرض عناصر وهمية
            final designer = _loading ? null : designerList[i];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: !_loading && designer?.avatarUrl != null
                      ? NetworkImage(designer!.avatarUrl!)
                      : null,
                ),
                title: Text(
                  designer?.name ?? 'Loading Name...',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  designer?.email ?? 'loading@email.com',
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: !_loading
                    ? () => Get.to(() => ProfileScreen(
                          currentDesigner: designer!,
                        ))
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
