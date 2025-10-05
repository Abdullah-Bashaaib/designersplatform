import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/error/exception.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../../../auth/domain/entities/user.dart';

abstract class ClientRemoteDataSource {
  Future<void> updateProfile(Client client);
  Future<List<User>> getFavoritesList();
  Future<List<Order>> getOrders();
  Future<String> addAvatar(XFile file);
  Future<void> deleteAvatar();
}

class ClientRemoteDataSourceImp implements ClientRemoteDataSource {
  final SupabaseClient _supabase;
  final FirebaseFirestore _firestore;

  ClientRemoteDataSourceImp(this._supabase, this._firestore);
  @override
  Future<void> updateProfile(Client client) {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getFavoritesList() {
    // TODO: implement getFavoritesList
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> getOrders() {
    // TODO: implement getOrders
    throw UnimplementedError();
  }

  @override
  Future<String> addAvatar(XFile image) async {
    try {
      final imageByte = await image.readAsBytes();
      final userId = CurrentUser.currentUser!.id;
      final imagePath = 'client/$userId/profile.png';
      await deleteAvatar();
      await _supabase.storage.from('avatars').uploadBinary(
            imagePath,
            imageByte,
          );
      final imageUrl =
          _supabase.storage.from('avatars').getPublicUrl(imagePath);
      try {
        await _firestore.collection('Users').doc(userId).update({
          'avatarUrl': imageUrl,
        });
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
        await _supabase.storage
            .from('avatars')
            .remove([CurrentUser.currentUser!.avatarUrl!]);
        await _firestore
            .collection('Users')
            .doc(CurrentUser.currentUser!.id)
            .update({'avatarUrl': ''});
        print('sssssssssssssssssssssssssssssssssssssss');
      } catch (e) {
        throw ServerException(e);
      }
    }
  }
}
