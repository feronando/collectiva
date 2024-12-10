import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/resource_entity.dart';

class ResourceHttp {
  var BASE_URL = "http://localhost:8080/api/v1/resource";

  Future<List<Resource>> getResources() async {
    var resposta = await http.get(Uri.parse(BASE_URL));

    if (resposta.statusCode == 200) {
      var responseJson = jsonDecode(resposta.body);
      List<dynamic> resourcesJson = responseJson['data']['content'];
      return resourcesJson.map((resource) => Resource.fromJson(resource)).toList();
    } else {
      throw Exception("Falha ao carregar recursos");
    }
  }

  Future<Resource> createResource(Resource resource) async {
    var body = jsonEncode(resource.toJson());
    var headers = {'Content-Type': 'application/json'};

    var resposta = await http.post(
      Uri.parse(BASE_URL),
      headers: headers,
      body: body,
    );

    if (resposta.statusCode == 201) {
      var responseJson = jsonDecode(resposta.body);
      var resourceJson = responseJson['data'];
      return Resource.fromJson(resourceJson);
    } else {
      throw Exception("Erro ao criar recurso: ${resposta.statusCode}");
    }
  }

  Future<void> deleteResource(int resourceId) async {
    var resposta = await http.delete(Uri.parse("$BASE_URL/$resourceId"));

    if (resposta.statusCode != 200) {
      throw Exception("Erro ao excluir recurso: ${resposta.statusCode}");
    }
  }

  Future<List<Resource>> filterResources({
    String? name,
    String? description,
  }) async {
    Map<String, String> queryParams = {};

    if (name != null) queryParams['name'] = name;
    if (description != null) queryParams['description'] = description;

    var uri = Uri.parse("$BASE_URL/filter").replace(queryParameters: queryParams);
    var resposta = await http.get(uri);

    if (resposta.statusCode == 200) {
      var responseJson = jsonDecode(resposta.body);
      List<dynamic> resourcesJson = responseJson['data']['content'];
      return resourcesJson.map((resource) => Resource.fromJson(resource)).toList();
    } else {
      throw Exception("Erro ao buscar recursos filtrados");
    }
  }
}
