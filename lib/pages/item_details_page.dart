import 'package:collectiva/entities/resource_entity.dart';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final resource = ModalRoute.of(context)!.settings.arguments as Resource;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 246, 246),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios, color: Color(0xFF00B4D8),)),
            Text(
              resource.name ?? "Nome Objeto",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.pink,))
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://picsum.photos/seed/488/600',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10,),
              const Text(
                "Detalhes",
                style: TextStyle(
                  color: Color(0xff8F9098),
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
              const Divider(
                color: Color(0xff8F9098),
                thickness: 0.2,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Descrição',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              Text(
                resource.description ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus  tincidunt elit non libero vulputate luctus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed at  risus in enim iaculis tincidunt at nec lectus. Morbi sit amet est  convallis, varius quam sit amet, fermentum metus. In tempor iaculis  ipsum nec.. Leia Mais",
                style: const TextStyle(
                  color: Color(0xff71727A),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Histórico',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}