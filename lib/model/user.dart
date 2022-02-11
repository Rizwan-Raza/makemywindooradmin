class User {
  String name;
  String email;
  String phone;
  String? company;
  bool? disabled;

  factory User.empty() =>
      User(name: "", email: "", phone: "", company: null, disabled: false);

  User(
      {required this.name,
      required this.email,
      required this.phone,
      this.company,
      this.disabled});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      company: map['company'],
      disabled: map['disabled'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'disabled': disabled,
    };
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, phone: $phone, company: $company, disabled: $disabled}';
  }
}
