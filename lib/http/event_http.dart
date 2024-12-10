import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entities/event_entity.dart';

class EventHttp {
  var BASE_URL = "http://localhost:8080/api/v1/event";

  Future<List<Event>> getEvents() async {
    var resposta = await http.get(Uri.parse(BASE_URL));
    print("resposta: ${resposta.body}");

    if (resposta.statusCode == 200) {
      var responseJson = jsonDecode(resposta.body);

      List<dynamic> postsJson = responseJson['data']['content'];

      print("Eventos: $postsJson");

      return postsJson.map((post) => Event.fromJson(post)).toList();
    } else {
      throw Exception("Falha ao carregar eventos");
    }
  }

  Future<Event> createEvent(Event event) async {
    var body = jsonEncode(event.toJson());
    print("Body: $body");

    var headers = {
      'Content-Type': 'application/json',
    };

    try {
      var resposta = await http.post(
        Uri.parse(BASE_URL),
        headers: headers,
        body: body,
      );

      if (resposta.statusCode == 201) {
        var responseJson = jsonDecode(resposta.body);

        var eventJson = responseJson['data'];

        print("Evento criado: $eventJson");
        return Event.fromJson(eventJson);
      } else {
        throw Exception("Erro ao criar evento: ${resposta.statusCode}");
      }
    } catch (e) {
      print("Erro ao enviar o evento: $e");
      throw Exception("Erro ao enviar evento");
    }
  }

  Future<void> deleteEvent(int eventId) async {
    try {
      var resposta = await http.delete(
        Uri.parse("$BASE_URL/$eventId"),
      );

      if (resposta.statusCode == 200) {
        print("Evento excluído com sucesso!");
      } else {
        throw Exception("Erro ao excluir evento: ${resposta.statusCode}");
      }
    } catch (e) {
      print("Erro ao excluir o evento: $e");
      throw Exception("Erro ao excluir evento");
    }
  }

  Future<List<Event>> filterEvents({
    String? queryEvent,
    String? name,
    String? location,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
  }) async {
    Map<String, String> queryParams = {};

    if (queryEvent != null) queryParams['queryEvent'] = queryEvent;
    if (name != null) queryParams['name'] = name;
    if (location != null) queryParams['location'] = location;
    if (category != null) queryParams['category'] = category;
    if (startDate != null) {
      queryParams['startDate'] = startDate.toIso8601String().split('T')[0];
    }
    if (endDate != null) {
      queryParams['endDate'] = endDate.toIso8601String().split('T')[0];
    }

    if (description != null) queryParams['description'] = description;

    var uri =
        Uri.parse("${BASE_URL}/filter").replace(queryParameters: queryParams);
    var resposta = await http.get(uri);

    if (resposta.statusCode == 200) {
      var responseJson = jsonDecode(resposta.body);
      List<dynamic> postsJson = responseJson['data']['content'];
      return postsJson.map((post) => Event.fromJson(post)).toList();
    } else {
      throw Exception("Erro ao buscar eventos filtrados");
    }
  }
}
