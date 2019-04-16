class User {
  String email, adress, phone;
  User({this.email, this.adress, this.phone});

  User.fromMap(Map<String, dynamic> data) : this(email: data['email'], adress: data['adress'], phone: data['phone']);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'adress': adress, 'phone': phone};
  }
}
