class CodeNotCheckException implements Exception{
  late String message;

  CodeNotCheckException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}