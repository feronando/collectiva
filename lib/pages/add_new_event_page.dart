import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../entities/event_entity.dart';
import '../providers/event_provider.dart';

class AddNewEventPage extends StatefulWidget {
  const AddNewEventPage({super.key});

  @override
  State<AddNewEventPage> createState() => _AddNewEventPageState();
}

class _AddNewEventPageState extends State<AddNewEventPage> {
  final _formKey = GlobalKey<FormState>();

  late String nome;
  late String descricao;
  late String local;
  late String categoria;

  DateTime _dataSelecionada = DateTime.now();
  bool dataFoiSelecionada = false;

  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: _dataSelecionada,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dataFoiSelecionada = true;
        _dataSelecionada = pickedDate;
      });
    });
  }

  void handleCreateEvent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final eventProvider = Provider.of<EventProvider>(context, listen: false);

      Event newEvent = Event(
        id: 0,
        name: nome,
        description: descricao,
        location: local,
        category: categoria,
        startDate: _dataSelecionada,
        endDate: _dataSelecionada,
      );

      eventProvider.createEvent(newEvent).then((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Evento criado com sucesso!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar evento: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 246, 246),
        title: const Text(
          "Cadastro de Evento",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Cadastre, organize e acompanhe os seus eventos",
                style: TextStyle(
                  color: Color.fromARGB(255, 114, 114, 114),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField(
                      label: 'Nome',
                      hintText: 'Adicione o nome do evento',
                      onSaved: (value) => nome = value!,
                    ),
                    const SizedBox(height: 10),
                    buildDateField(),
                    const SizedBox(height: 10),
                    buildTextField(
                      label: 'Descrição',
                      hintText: 'Adicione descrição',
                      onSaved: (value) => descricao = value!,
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      label: 'Local',
                      hintText: 'Adicione o local do evento',
                      onSaved: (value) => local = value!,
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      label: 'Categoria',
                      hintText: 'Adicione uma categoria',
                      onSaved: (value) => categoria = value!,
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => handleCreateEvent(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color(0xFF00B4D8),
                        ),
                        child: const Text(
                          'Cadastrar Evento',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hintText,
    required void Function(String?) onSaved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
          onSaved: onSaved,
        ),
      ],
    );
  }

  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Data',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: !dataFoiSelecionada
                ? 'Selecione a data do evento'
                : 'Data selecionada: ${DateFormat('dd/MM/y').format(_dataSelecionada)}',
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 12),
            suffixIcon: GestureDetector(
              onTap: _showDatePicker,
              child: const Icon(
                Icons.calendar_month,
                size: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
