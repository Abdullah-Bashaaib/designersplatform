import 'package:designers_platform/features/search/domain/usecase/search_designers.dart';
import 'package:designers_platform/features/search/domain/usecase/search_designs.dart';
import 'package:get/get.dart';

class SearchControl extends GetxController {
  final SearchDesignsUsecase designsUsecase;
  final SearchDesignersUsecase designersUsecase;

  SearchControl(this.designsUsecase, this.designersUsecase);

  var isLoading = false.obs;
  var query = ''.obs;
  var resultsDesigns = [].obs;
  var resultsDesigners = [].obs;

  //  البحث عن المصممين
  Future<void> searchDesigners(String query) async {
    isLoading.value = true;
    final result = await designersUsecase.call(query);
    result.fold((f) {}, (r) {
      resultsDesigners.value = r;
    });
    isLoading.value = false;
  }

  //  البحث عن التصاميم
  Future<void> searchDesigns(String query) async {
    isLoading.value = true;
    final result = await designsUsecase.call(query);
    result.fold((f) {}, (r) {
      resultsDesigns.value = r;
    });
    isLoading.value = false;
  }
}
