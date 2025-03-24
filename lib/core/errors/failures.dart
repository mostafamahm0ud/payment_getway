class Failures {
  final String errmessage;

  Failures({required this.errmessage});
}

class ServerFailures extends Failures {
  ServerFailures({required super.errmessage});
}
