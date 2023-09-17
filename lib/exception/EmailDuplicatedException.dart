
class EmailDuplicatedException implements Exception{
  late String message;

  EmailDuplicatedException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}