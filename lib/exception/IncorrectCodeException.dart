
class IncorrectCodeException implements Exception{
  late String message;

  IncorrectCodeException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}