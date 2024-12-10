import 'package:collectiva/pages/profile_page.dart';
import 'package:collectiva/pages/events_page.dart';
import 'package:collectiva/utils/routes.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'inventory_page.dart';

class TabsController extends StatefulWidget {
  const TabsController({super.key});

  @override
  State<TabsController> createState() => _TabsControllerState();
}

class _TabsControllerState extends State<TabsController> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    EventsScreen(),
    InventoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Align(
              alignment: Alignment.center,
              child: Text(
                'Escolha a opção desejada:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Adicionar Evento'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(CollectivaRoutes.NEW_EVENT);
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Adicionar Item'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(CollectivaRoutes.NEW_ITEM);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFFFFFFFF),
        unselectedItemColor: const Color(0xFF606060),
        backgroundColor: const Color(0xFF212121),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: "Eventos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: "Inventário",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_cal),
            label: "Perfil",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOptions(context),
        backgroundColor: Color(0xFF00B4D8),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: const Color(0xFFFFFFFF),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
