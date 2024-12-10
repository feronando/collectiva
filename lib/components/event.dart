import 'package:flutter/material.dart';

import '../entities/event_entity.dart';

class EventoWidget extends StatelessWidget {
  final Event event;

  const EventoWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF1F3FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF212121)),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do evento
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://picsum.photos/seed/488/600',
                width: double.infinity,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            // Nome do evento
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.name ?? 'Nome do evento',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                // Data e local
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Color(0xFF212121)),
                        SizedBox(width: 5),
                        Text(
                          event.startDate != null
                              ? '${event.startDate!.day}/${event.startDate!.month}/${event.startDate!.year}'
                              : 'Data não definida',
                          style: TextStyle(
                            color: Color(0xFF545454),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.place, size: 16, color: Color(0xFF212121)),
                        SizedBox(width: 5),
                        Text(
                          event.location ?? 'Local não definido',
                          style: TextStyle(
                            color: Color(0xFF545454),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            // Descrição
            Text(
              event.description ?? 'Descrição curta do evento...',
              style: TextStyle(
                color: Color(0xFF545454),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}