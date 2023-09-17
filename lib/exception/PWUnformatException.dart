class PWUnformatException implements Exception{
  late String message;

  PWUnformatException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}