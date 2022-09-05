class Order{
  int id;
  String name;
  String phone;
  String username;
  String date;
  String fullname;
  Order({required this.id,required this.name,required this.phone,required this.username, required this.date, required this.fullname});

  factory Order.fromJson(Map<String,dynamic> json) {
    return Order(
      id: json['id'] as int,
      name: json['name'],
      phone: json['phone'],
      username: json["username"],
      date: json["date"],
      fullname: json["fullname"],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'name': name,
      'phone':phone,
      'username':username,
      'date':date,
      'fullname':fullname
    };
  }
}