import 'package:flutter/material.dart';
import '../entities/resource_entity.dart';

class ItemWidget extends StatefulWidget {
  final Resource resource; // Passa o recurso para o widget

  const ItemWidget({super.key, required this.resource});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth = screenWidth * 0.3;
    double containerHeight = screenHeight * 0.2;

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Color(0xFFF1F3FF),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(
              0,
              2,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              widget.resource.name ?? 'Nome do item', // Exibe o nome do recurso
              style: TextStyle(
                fontSize: screenWidth < 600 ? 14 : 18, // Ajusta o tamanho do texto para telas menores
              ),
            ),
          ),
        ],
      ),
    );
  }
}
