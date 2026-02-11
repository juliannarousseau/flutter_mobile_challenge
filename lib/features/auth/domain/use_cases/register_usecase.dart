import 'package:flutter_mobile_challenge/features/auth/domain/repository/auth_repository_interface.dart';

class LoginUseCase{
  final AuthRepositoryInterface repository;
  LoginUseCase(this.repository);
  
Future call() async { 
    return await repository.registerUser(); //Chama a função do repositório para fazer registro do usuário
  }
}