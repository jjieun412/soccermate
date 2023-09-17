
class NickDuplicatedException implements Exception{
  late String message;

  NickDuplicatedException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}