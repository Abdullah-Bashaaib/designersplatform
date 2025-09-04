import 'package:designers_platform/core/error/messages.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = error]);
}

class NoUserFailure extends Failure {
  const NoUserFailure([super.message = noUser]);
}

class OfflineFailure extends Failure {
  const OfflineFailure([super.message = "No Internet Connection"]);
}

class LocalFailure extends Failure {
  const LocalFailure([super.message = error]);
}
