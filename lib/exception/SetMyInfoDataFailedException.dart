class SetMyInfoDataFailedException implements Exception{
  late String message;

  SetMyInfoDataFailedException(String msg)
  {
    this.message = msg;
  }

  String toString() {
    return message;
  }

}