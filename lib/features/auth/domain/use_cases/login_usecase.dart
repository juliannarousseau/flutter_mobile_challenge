import 'package:flutter_mobile_challenge/features/auth/domain/repository/auth_repository_interface.dart';

class LoginUseCase{
  final AuthRepositoryInterface repository;
  LoginUseCase(this.repository);
  
Future call() async { 
    return await repository.loginUser(); //Chama a função do repositório para fazer login do usuário
  }
  
}