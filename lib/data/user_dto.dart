class user_dto{
  late String role;
  late int userId;

  static final String USER = "USER";
  static final String REGISTRATION_NOT_COMPLETE_USER = "REGISTRATION_NOT_COMPLETE_USER";

  user_dto({required String this.role, required int this.userId});

}