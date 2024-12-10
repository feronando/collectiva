import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/user_entity.dart';

class AuthHttp {
  var BASE_URL = "http://localhost:8080/api/v1/auth";
  var USER_URL = "http://localhost:8080/api/v1/user-info";


  Future<User> login(String? email, String? password) async {
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var headers = {
      'Content-Type': 'application/json',
    };

    print("body ${body}");

    try {
      var resposta = await http.post(
        Uri.parse("${BASE_URL}/login"),
        headers: headers,
        body: body,
      );

      print("resposta ${resposta.body}, ${resposta.statusCode}");

      if (resposta.statusCode == 200) {
        var responseJson = jsonDecode(resposta.body);
        var userJson = responseJson['data'];
        return User.fromJson(userJson);
      } else {
        throw Exception("Erro ao logar: ${resposta.statusCode}");
      }
    } catch (e) {
      print("erro");
      throw Exception("Erro ao logar: $e");
    }
  }

  Future<User> signup(String? email, String? password, String? name, String? cpf) async {
    var body = jsonEncode({
      'email': email,
      'password': password,
      'person': {
        'name': name,
        'cpf': cpf
      }
    });

    var headers = {
      'Content-Type': 'application/json',
    };

    print("body ${body}");

    try {
      var resposta = await http.post(
        Uri.parse(USER_URL),
        headers: headers,
        body: body,
      );

      print("resposta ${resposta}");

      if (resposta.statusCode == 201) {
        var responseJson = jsonDecode(resposta.body);
        var userJson = responseJson['data'];
        return User.fromJson(userJson);
      } else {
        throw Exception("Erro ao criar usuário: ${resposta.statusCode}");
      }
    } catch (e) {
      print("erro");
      throw Exception("Erro ao criar usuário: $e");
    }
  }
}
