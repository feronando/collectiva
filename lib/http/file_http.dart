import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:http_parser/http_parser.dart';

class FileHttp {
  var BASE_URL = "http://localhost:8080/api/v1/file";

  Future<void> uploadFileFromBytes(List<int> fileBytes, String fileName) async {
    var uri = Uri.parse(BASE_URL);
    var request = http.MultipartRequest('POST', uri);

    var multipartFile = http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: fileName,
      contentType:
          MediaType('image', 'jpeg'), // Adjust content type accordingly
    );

    request.files.add(multipartFile);
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print(responseData); // Print success response
    } else {
      var responseData = await response.stream.bytesToString();
      print('Failed to upload: $responseData'); // Print failure response
    }
  }

  Future<void> downloadFile(String fileId, String savePath) async {
    var url = Uri.parse('$BASE_URL/$fileId');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        File file = File(savePath);
        await file.writeAsBytes(response.bodyBytes);
        print('Arquivo salvo em $savePath');
      } else {
        print('Falha ao baixar arquivo: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao baixar arquivo: $e');
    }
  }
}
