import 'package:flutter/material.dart';
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
    

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CounterPage(notifier: notifier),
    );
  }
}
