import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../domain/i_internet_info.dart';

class NetworkInfoImpl implements INetworkInfo {
  final InternetConnectionChecker _connectionChecker;

  NetworkInfoImpl(this._connectionChecker);

  @override
  Future<bool> get isConnected => _connectionChecker.hasConnection;

  @override
  Stream<bool> get onConnectionChanged {
    // الباكج يرجع InternetConnectionStatus
    // نحن نحوله إلى bool لتطابق العقد في الـ domain
    return _connectionChecker.onStatusChange.map((status) {
      return status == InternetConnectionStatus.connected;
    });
  }
}
