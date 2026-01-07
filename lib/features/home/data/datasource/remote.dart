import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Remote {
  Future<List<Designer>> getDesigners({int limit = 10, Designer? startAfter});
}

class RemoteImp implements Remote {
  final SupabaseClient supabase;

  RemoteImp(this.supabase);

  @override
  Future<List<Designer>> getDesigners({int limit = 10, Designer? startAfter}) async {
    try {
      // بناء الاستعلام
      var query = supabase
          .from('users')
          .select()
          .eq('role', 'مصمم')
          .order('id', ascending: true)
          .limit(limit);

      // إذا أردت عمل Pagination
      if (startAfter != null) {
        // Supabase لا يدعم startAfter مباشرة، لذلك نستخدم range
        // مثال: نبحث عن المصفوفة بداية من index محدد
        // افترض أن startAfter.id يمكن تحويله إلى index أو تستخدم created_at كمعيار
        // يمكنك تعديل حسب حاجتك
      }

      final result = await query;

      if (result is List) {
        return result.map((d) => DesignerModel.fromJson(d)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
