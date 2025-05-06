class User {
  final int? _id;
  final String _name;
  final String _email;
  final String _password;

  User({
    int? id,
    required String name,
    required String email,
    required String password,
  }) : _id = id,
       _name = name,
       _email = email,
       _password = password;

  int? get id => _id;
  String get name => _name;
  String get email => _email;
  String get password => _password;

  Map<String, dynamic> toJson(){
    return{
      "id":_id,
      "name": _name,
      "email":_email,
      "passoword":_password
    };
  }
}
