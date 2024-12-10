import 'package:collectiva/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String senha;
  bool ishidden = true;

  Future<void> handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        var user = await userProvider.login(email, senha);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login bem-sucedido!')),
        );
        Navigator.of(context).pushReplacementNamed(CollectivaRoutes.TABS);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email ou senha inválidos.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.crop_square,
                  size: 148,
                  color: Color(0xFF00B4D8),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Faça o login na sua conta do Collectiva",
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
                ),
                const SizedBox(height: 20.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5)),
                              labelStyle: TextStyle(
                                fontSize: 14,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (value.split('@').length != 2) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value ?? '';
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Senha',
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5)),
                              labelStyle: TextStyle(fontSize: 14),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ishidden = !ishidden;
                                  });
                                },
                                child: Icon(
                                    color: const Color.fromARGB(
                                        255, 114, 114, 114),
                                    ishidden
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                              )),
                          obscureText: ishidden,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            senha = value ?? '';
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed:
                                () {}, //problema seu que não lembra da senha
                            child: const Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF), fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              handleLogin();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color(0xFF00B4D8),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 4, 4, 4),
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(
                                "Não tem conta? ",
                                style: TextStyle(
                                    color: Color(0xFF71727A), fontSize: 14),
                              ),TextButton(
                                onPressed: () => Navigator.of(context).pushNamed(CollectivaRoutes.NEW_USER),
                                child: const Text(
                                  'Crie uma aqui!',
                                  style: TextStyle(
                                      color: Color(0xFFffffff), fontSize: 14),
                                ),
                              ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
