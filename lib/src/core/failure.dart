import 'package:http/http.dart';

class Failure {
  Failure({
    this.e,
    this.s,
    this.msg,
    this.code,
  });
  final Object? e;
  final StackTrace? s;
  final String? msg;
  final FailureCode? code;
}

enum FailureCode {
  serverError,
  clientError,
}

FailureCode getFailureCodeFromResponse({required Response response}) {
  if (response.statusCode.toString().startsWith('4')) {
    return FailureCode.clientError;
  } else if (response.statusCode.toString().startsWith('5')) {
    return FailureCode.serverError;
  }
  throw UnimplementedError('Status code not handled');
}
