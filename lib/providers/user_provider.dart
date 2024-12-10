import 'package:flutter/material.dart';
import '../entities/user_entity.dart';
import '../http/auth_http.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthHttp authHttp = AuthHttp();

  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      _user = await authHttp.login(email, password);
      notifyListeners();
    } catch (e) {
      throw Exception("Erro ao logar: $e");
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  // Função de cadastro (signup)
  Future<void> signup(String? email, String? password, String? name, String? cpf) async {
    try {
      _user = await authHttp.signup(email, password, name, cpf);
      print("user ${_user?.email}, ${_user}");
      notifyListeners();
    } catch (e) {
      throw Exception("Erro ao criar usuário: $e");
    }
  }
}
