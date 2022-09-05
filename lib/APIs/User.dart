class User{
  String img;
  String fullname;
  String username;
  String password;
  String phone;
  String token;
  User({required this.fullname,required this.username,required this.password,required this.phone,required this.img,required this.token});
  @override
  String toString() {
    return "username:$username \npassword:$password \nfullname:$fullname \nphone:$phone \nimage:$img \ntoken:$token";
  }
}