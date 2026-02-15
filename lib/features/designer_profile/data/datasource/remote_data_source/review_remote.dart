import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/designer_profile/data/models/reivew_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ReviewRemote {
  Future<void> addReview(ReviewModel reviewModel);
  Future<List<ReviewModel>> getReview();
}

class ReviewRemoteImp implements ReviewRemote {
  final SupabaseClient supabase;

  ReviewRemoteImp(this.supabase);

  @override
  Future<void> addReview(ReviewModel reviewModel) async {
    try {
      await supabase.from('reviews').insert([reviewModel.toJson()]);
    } catch (e) {
      // print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ReviewModel>> getReview() async {
    try {
      print('e.toString()');

      String typeId = '';
      if (CurrentUser.currentUser?.role == 'مصمم') {
        typeId = 'designer_id';
      } else {
        typeId = 'client_id';
      }
      final response = await supabase
          .from('reviews')
          .select()
          .eq(typeId, CurrentUser.currentUser!.id);
      return response.map((m) => ReviewModel.fromJson(m)).toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(e.toString());
    }
  }
}
