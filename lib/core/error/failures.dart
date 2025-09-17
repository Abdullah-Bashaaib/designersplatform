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
  const OfflineFailure([super.message = offlineError]);
}

class LocalFailure extends Failure {
  const LocalFailure([super.message = error]);
}

class NoDataFailure extends Failure {
  final String errorMessage;

  const NoDataFailure(this.errorMessage) : super(errorMessage);
}

class EmptyLocalDatabaseFailure extends Failure {
  const EmptyLocalDatabaseFailure([super.message = emptyLocalDatabase]);
}
