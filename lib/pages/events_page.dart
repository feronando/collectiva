import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/event.dart';
import '../providers/event_provider.dart';
import '../utils/routes.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega os eventos assim que a tela é inicializada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).getEvents();
    });
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
                  'Eventos',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_alt_outlined, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            if (eventProvider.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (eventProvider.errorMessage != null) {
              return Center(
                child: Text(
                  eventProvider.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            if (eventProvider.events.isEmpty) {
              return Center(
                child: Text('Nenhum evento encontrado'),
              );
            }

            return ListView.builder(
              itemCount: eventProvider.events.length,
              itemBuilder: (context, index) {
                final event = eventProvider.events[index];
                return GestureDetector(
                  onTap: () {Navigator.of(context).pushNamed(CollectivaRoutes.EVENT_DETAILS, arguments: event);},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: EventoWidget(event: event),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
