import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../state/counter_notifier.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CounterController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Counter (GetX)')),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator();
          }
          final value = controller.counter ?? 0;
          return Text('Count: $value', style: const TextStyle(fontSize: 24));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
