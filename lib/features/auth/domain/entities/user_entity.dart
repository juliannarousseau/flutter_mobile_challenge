class UserEntity{ //Classe abstrata para representar o usuário
  final int id;
  final String name;
  final String username;
  final String email;
  final String password;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password
  });
}