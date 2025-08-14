import 'package:designers_platform/features/login/presentation/state/counter_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/login/data/datasources/counter_local_data_source.dart';
import 'features/login/data/repositories/counter_repository_impl.dart';
import 'features/login/domain/usecases/get_counter.dart';
import 'features/login/domain/usecases/increment_counter.dart';
import 'features/login/presentation/pages/counter_page.dart';
import 'features/login/presentation/state/counter_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Designer Platform',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: CounterBinding(),
      home: CounterPage(),
    );
  }
}
