class CodeNotSentException implements Exception{
  late String message;

  CodeNotSentException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}