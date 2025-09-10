import 'package:designers_platform/core/utils/messages.dart';

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
  const OfflineFailure([super.message = offLineError]);
}

class LocalFailure extends Failure {
  const LocalFailure([super.message = error]);
}

class EmptyLocalDatabaseFailure extends Failure {
  const EmptyLocalDatabaseFailure([super.message = emptyLocalDatabase]);
}
