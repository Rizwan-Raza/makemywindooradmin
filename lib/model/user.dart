class User {
  String name;
  String email;
  String phone;
  String? company;

  factory User.empty() => User(name: "", email: "", phone: "", company: null);

  User(
      {required this.name,
      required this.email,
      required this.phone,
      this.company});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      company: map['company'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
    };
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, phone: $phone, company: $company}';
  }
}
