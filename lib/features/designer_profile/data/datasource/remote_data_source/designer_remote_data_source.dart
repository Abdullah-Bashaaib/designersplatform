import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/designer_profile/data/models/designer_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DesignerRemoteDataSource {
  Future<DesignerModel?> getData(String id);
  Future<Unit> updateData(DesignerModel designer);
  Future<Unit> deleteData(String id);
}

class DesignerRemoteDataSourceImpBySupabase
    implements DesignerRemoteDataSource {
  final SupabaseClient supabase;

  DesignerRemoteDataSourceImpBySupabase({required this.supabase});

  @override
  Future<DesignerModel?> getData(String id) async {
    try {
      log("------------------------------------->  in Supabase : $id");

      final data =
          await supabase.from('users').select().eq('id', id).maybeSingle();
      if (data == null) return null;
      return DesignerModel.fromJson(data);
    } catch (e) {
      log("-------------------------------------> Error in Supabase : $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Unit> updateData(DesignerModel designer) async {
    try {
      await supabase
          .from('users')
          .update(designer.toJson())
          .eq('id', designer.id);
      return unit;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Unit> deleteData(String id) async {
    try {
      await supabase.from('users').delete().eq('id', id);
      return unit;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
