class EmailUnformatException implements Exception{
  late String message;

  EmailUnformatException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}