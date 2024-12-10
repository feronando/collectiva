import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  late String nome;
  late String email;
  late String senha;
  late String confirmarSenha;
  late String cpf;

  bool _ishidden = true;
  bool _ishidden2 = true;

  void handleSignup(UserProvider userProvider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (senha != confirmarSenha) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senhas não iguais')),
        );
        return;
      }

      try {
        print("singuppage ${email}, ${senha}, ${nome}, ${cpf}");
        await userProvider.signup(email, senha, nome, cpf);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        // Redireciona após o cadastro bem-sucedido
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro de Usuário",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF9F9F9),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Crie sua conta e começe a organizar seu estoque agora",
                style: TextStyle(
                  color: Color.fromARGB(255, 114, 114, 114),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Nome
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Nome',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Nome Sobrenome',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 114, 114, 114),
                              fontWeight: FontWeight.w300),
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          labelStyle: TextStyle(fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nome = value ?? '';
                        },
                      ),
                      const SizedBox(height: 10.0),

                      // CPF
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('CPF',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Digite seu CPF',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 114, 114, 114),
                              fontWeight: FontWeight.w300),
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          labelStyle: TextStyle(fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          // Adicione uma validação de CPF se necessário
                          return null;
                        },
                        onSaved: (value) {
                          cpf = value ?? '';
                        },
                      ),
                      const SizedBox(height: 10.0),

                      // Email
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Email',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'nome@email.com',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 114, 114, 114),
                                fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            labelStyle: TextStyle(fontSize: 14)),
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
                      const SizedBox(height: 10.0),

                      // Senha
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Senha',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 114, 114, 114),
                                fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            labelStyle: TextStyle(fontSize: 14),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _ishidden = !_ishidden;
                                });
                              },
                              child: Icon(
                                  color:
                                  const Color.fromARGB(255, 114, 114, 114),
                                  _ishidden
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                            )),
                        obscureText: _ishidden,
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

                      // Confirmar senha
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Confirmar senha',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 114, 114, 114),
                                fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            labelStyle: TextStyle(fontSize: 14),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _ishidden2 = !_ishidden2;
                                });
                              },
                              child: Icon(
                                  color:
                                  const Color.fromARGB(255, 114, 114, 114),
                                  _ishidden2
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                            )),
                        obscureText: _ishidden2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          confirmarSenha = value ?? '';
                        },
                      ),
                      const SizedBox(height: 20.0),

                      // Botão de cadastro
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => handleSignup(context.read<UserProvider>()),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 42, 184, 154),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
