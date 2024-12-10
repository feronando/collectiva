import 'package:flutter/material.dart';
import '../entities/resource_entity.dart';
import '../http/resource_http.dart';

class ResourceProvider extends ChangeNotifier {
  List<Resource> _resources = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Resource> get resources => _resources;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ResourceHttp resourceHttp = ResourceHttp();

  Future<void> getResources() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _resources = await resourceHttp.getResources();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createResource(Resource resource) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      Resource createdResource = await resourceHttp.createResource(resource);
      _resources.add(createdResource);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteResource(int resourceId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await resourceHttp.deleteResource(resourceId);
      _resources.removeWhere((resource) => resource.id == resourceId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterResources({
    String? name,
    String? description,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _resources = await resourceHttp.filterResources(
        name: name,
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
