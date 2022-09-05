class SavedUser{
  String username;
  String password;

  SavedUser({
    required this.username, 
    required this.password, 
  });

  SavedUser.fromMap(Map<String, dynamic> res)
      : username = res["username"],
        password = res["password"];

  Map<String, Object?> toMap() {
    return {'username': username, 'password': password};
  }
}