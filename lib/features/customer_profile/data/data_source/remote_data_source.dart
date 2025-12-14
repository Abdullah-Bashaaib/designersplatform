import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../../../auth/domain/entities/user.dart';

abstract class ClientRemoteDataSource {
  Future<void> updateUserName(String name);
  Future<List<UserEntity>> getFavoritesList();
  Future<String> addAvatar(XFile file);
  Future<void> deleteAvatar();
}

class ClientRemoteDataSourceImp implements ClientRemoteDataSource {
  final SupabaseClient supabase;

  ClientRemoteDataSourceImp(
    this.supabase,
  );
  @override
  Future<void> updateUserName(String name) async {
    try {
      final userId = CurrentUser.currentUser!.id;

      final response =
          await supabase.from('users').update({'name': name}).eq('id', userId);

      if (response.error != null) {
        throw ServerException(response.error!.message);
      }
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<UserEntity>> getFavoritesList() {
    throw UnimplementedError();
  }

  @override
  Future<String> addAvatar(XFile image) async {
    try {
      final imageByte = await image.readAsBytes();
      final userId = CurrentUser.currentUser!.id;
      final imagePath = '$userId/profile.png';
      print(imagePath);
      if (CurrentUser.currentUser!.avatarUrl != null) {
        await deleteAvatar();
      }
      await supabase.storage.from('avatars').uploadBinary(
            imagePath,
            imageByte,
          );
      final imageUrl = supabase.storage.from('avatars').getPublicUrl(imagePath);
      try {
        await supabase
            .from('users')
            .update({'avatarUrl': imageUrl}).eq('id', userId);
      } catch (e) {
        throw ServerException(e);
      }
      return imageUrl;
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<void> deleteAvatar() async {
    if (CurrentUser.currentUser!.avatarUrl != null) {
      try {
        final path = '${CurrentUser.currentUser!.id}/profile.png';
        print(path);
        await supabase.storage.from('avatars').remove([path]);
        await supabase
            .from('users')
            .update({'avatarUrl': ''}).eq('id', CurrentUser.currentUser!.id);
      } catch (e) {
        throw ServerException(e);
      }
    }
  }
}
