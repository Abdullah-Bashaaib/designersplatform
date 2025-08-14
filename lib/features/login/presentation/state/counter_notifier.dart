import 'package:get/get.dart';
import '../../domain/entities/counter.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../../../core/usecase/usecase.dart';

class CounterController extends GetxController {
  // حالة تفاعلية
  int counter = 0.abs();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // load(); // تحميل أولي
  }

  Future<void> increment() async {
    isLoading.value = true;
    try {
      counter++;
    } finally {
      isLoading.value = false;
    }
  }
}
