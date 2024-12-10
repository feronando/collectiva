import 'package:collectiva/entities/event_entity.dart';
import 'package:collectiva/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/event.dart';
import '../providers/event_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDay = 0;
  List<String> _daysOfWeek = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];
  DateTime _today = DateTime.now();
  List<String> _formattedDays = [];
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _formatDays();
  }

  void _formatDays() {
    _formattedDays.add("${_daysOfWeek[_today.weekday - 1]}, ${_today.day}");
    for (int i = 1; i < 5; i++) {
      DateTime nextDay = _today.add(Duration(days: i));
      _formattedDays.add("${_daysOfWeek[nextDay.weekday - 1]}, ${nextDay.day}");
    }
    setState(() {

    });
  }

  void _onDaySelected(int index) async {
    setState(() {
      _selectedDay = index;
    });

    final DateTime selectedDate = _today.add(Duration(days: index));
    final EventProvider eventProvider =
    Provider.of<EventProvider>(context, listen: false);

    await eventProvider.filterEvents(
      startDate: selectedDate,
      endDate: selectedDate,
    );

    setState(() {
      _events = eventProvider.events;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<EventProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Color(0xFF212121),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bem-Vindo',
                        style: TextStyle(color: Color(0xFF00B4D8), fontSize: 12),
                      ),
                      Text(
                        "Tales Henrique",
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Eventos da semana", style: TextStyle(color: Colors.black, fontSize: 16)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _onDaySelected(index),
                      child: Container(
                        height: 90,
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: _selectedDay == index
                              ? Color(0xFF00B4D8)
                              : Color(0xFFF1F3FF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _formattedDays[index].split(',')[0],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _selectedDay == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                _formattedDays[index].split(',')[1],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: _selectedDay == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Consumer<EventProvider>(
                builder: (context, eventProvider, child) {
                  return _events.isEmpty
                      ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Não há eventos nesta data',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      return GestureDetector (
                        onTap: () {Navigator.of(context).pushNamed(CollectivaRoutes.EVENT_DETAILS, arguments: _events[index]);},
                        child: ListTile(
                          title: EventoWidget(event: _events[index]),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                'Categorias',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        'Categoria ${index + 1}',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
