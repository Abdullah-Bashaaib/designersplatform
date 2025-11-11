import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/home/domain/usecases/get_designers.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetDesignersUsecase getDesignersUsecase;

  HomeController(this.getDesignersUsecase);

  var isLoading = false.obs;
  var designerList = <Designer>[].obs;

  @override
  void onInit() {
    getDesigners();
    super.onInit();
  }

  Future<void> getDesigners() async {
    isLoading.value = true;
    final result = await getDesignersUsecase.call();
    result.fold((f) {
      DialogHelper.showErrorSnackBar(title: 'خطـــأ', message: f.message);
    }, (r) {
      designerList.value = r;
    });
    isLoading.value = false;
  }
}
