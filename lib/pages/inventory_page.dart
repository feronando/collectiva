import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../entities/resource_entity.dart';
import '../providers/resource_provider.dart';
import '../components/item.dart';
import '../utils/routes.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
    // Carregar os recursos ao iniciar a tela
    Provider.of<ResourceProvider>(context, listen: false).getResources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF212121),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  'Inventário',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<ResourceProvider>(
          builder: (context, resourceProvider, child) {
            // Verifica se está carregando ou ocorreu um erro
            if (resourceProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (resourceProvider.errorMessage != null) {
              return Center(
                child: Text(
                  'Erro: ${resourceProvider.errorMessage}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            // Exibe os recursos na grid
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
              ),
              itemCount: resourceProvider.resources.length,
              itemBuilder: (context, index) {
                final resource = resourceProvider.resources[index];
                return GestureDetector(
                    onTap: () {Navigator.of(context).pushNamed(CollectivaRoutes.ITEM_DETAILS, arguments: resource);},
                    child: ItemWidget(resource: resource));
              },
            );
          },
        ),
      ),
    );
  }
}
