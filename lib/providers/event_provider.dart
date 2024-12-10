import 'package:flutter/material.dart';
import '../entities/event_entity.dart';
import '../http/event_http.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final EventHttp eventHttp = EventHttp();

  Future<void> getEvents() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _events = await eventHttp.getEvents();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createEvent(Event event) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      Event createdEvent = await eventHttp.createEvent(event);
      _events.add(createdEvent);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEvent(int eventId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await eventHttp.deleteEvent(eventId);
      _events.removeWhere((event) => event.id == eventId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterEvents({
    String? queryEvent,
    String? name,
    String? location,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _events = await eventHttp.filterEvents(
        queryEvent: queryEvent,
        name: name,
        location: location,
        category: category,
        startDate: startDate,
        endDate: endDate,
        description: description,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
