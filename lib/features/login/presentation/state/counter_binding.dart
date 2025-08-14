import 'package:get/get.dart';
import 'counter_notifier.dart';

class CounterBinding extends Bindings {
  @override
  void dependencies() {
    // يفترض أن GetCounter و IncrementCounter مسجّلين بـ Get.put أو Get.lazyPut
    Get.lazyPut<CounterController>(() => CounterController());
  }
}