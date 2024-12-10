import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../entities/resource_entity.dart';
import '../providers/resource_provider.dart';

class AddNewItemPage extends StatefulWidget {
  const AddNewItemPage({super.key});

  @override
  State<AddNewItemPage> createState() => _AddNewItemPageState();
}

class _AddNewItemPageState extends State<AddNewItemPage> {
  final _formKey = GlobalKey<FormState>();
  late String nome;
  late String descricao;
  bool isLoading = false;
  String? errorMessage;

  void handleCreateResource() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final resourceProvider = Provider.of<ResourceProvider>(context, listen: false);

      Resource newResource = Resource(
        name: nome,
        description: descricao,
      );

      resourceProvider.createResource(newResource).then((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item cadastrado com sucesso!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar item: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF9F9F9),
        title: Text(
          "Cadastro de Item",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffF9F9F9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Cadastre um novo item e comece a rastreá-lo",
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Nome',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ex.: Notebook Lenovo',
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
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Descrição',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Adicione descrição',
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
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        descricao = value ?? '';
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: handleCreateResource,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color(0xFF00B4D8),
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF), fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
