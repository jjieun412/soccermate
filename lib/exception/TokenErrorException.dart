
class TokenErrorException implements Exception{
  late String message;

  TokenErrorException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}