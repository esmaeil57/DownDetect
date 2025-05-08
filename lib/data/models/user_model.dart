class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
    confirmPassword: json['confirmpassword'],
    role: json['role'],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "role": role,
  };
}
