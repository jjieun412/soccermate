class LoginFailedException implements Exception{
  late String message;

  LoginFailedException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}