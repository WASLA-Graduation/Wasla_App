abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure() : super('No Internet Connection');
}

class ServerFailure extends Failure {
  const ServerFailure([super.msg = 'Server Error']);
}
