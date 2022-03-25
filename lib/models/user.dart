class User {
  final String nome;

  const User({required this.nome});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(nome: json['name']);
  }
}
