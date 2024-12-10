// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:trabalho_mobile/http/file_http.dart';

// class FileProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   final FileHttp fileHttp = FileHttp();

//   Future<void> uploadFile(File file) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     print("file ${file}");

//     try {
//       await fileHttp.uploadFile(file);
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
