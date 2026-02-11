class PostEntity {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostEntity ({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  }); 

  // Example method to validate the entity (Verifica se os campos são válidos)
  bool isValid() => title.isNotEmpty && body.isNotEmpty;
  
}
