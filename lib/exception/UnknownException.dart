class UnknownException implements Exception{
  late String message;

  UnknownException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}