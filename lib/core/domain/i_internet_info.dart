// هذا العقد لا يعتمد على أي باكجات خارجية، فقط Dart.
abstract class INetworkInfo {
  /// جلب الحالة الحالية للاتصال (للفحص لمرة واحدة)
  Future<bool> get isConnected;

  /// "ليسنر" (Stream) لمتابعة أي تغيير في حالة الاتصال
  Stream<bool> get onConnectionChanged;
}
