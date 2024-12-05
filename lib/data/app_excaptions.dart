// ignore_for_file: prefer_typing_uninitialized_variables

class AppExcaptions implements Exception {
  final _message;
  final _prefix;

  AppExcaptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppExcaptions {
  FetchDataException([String? message])
      : super(message, 'Error during cummunication');
}

class BadRequestException extends AppExcaptions {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnauthorisedException extends AppExcaptions {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}

class InvalidInputException extends AppExcaptions {
  InvalidInputException([String? message])
      : super(message, 'InvalidInput request');
}
