// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import '../../models/faculty/portions_model.dart';
// import '../../config/mapp_config.dart';

// class PortionService {
//   final String baseUrl = AppConfig.facPortionsUrl;
//   final String accessToken = AppConfig.accessToken;

//   Future<bool> postPortion(Portion portion, File? image, File? document) async {
//     var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
//       ..headers['Authorization'] = 'Bearer $accessToken'
//       ..fields.addAll(portion.toJson().map((key, value) => MapEntry(key, value.toString())));

//     if (image != null) {
//       request.files.add(await http.MultipartFile.fromPath('image', image.path));
//     } else {
//       request.fields['image'] = 'null';
//     }

//     if (document != null) {
//       request.files.add(await http.MultipartFile.fromPath('document', document.path));
//     } else {
//       request.fields['document'] = 'null';
//     }

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }


import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../../config/mapp_config.dart';
import 'package:http_parser/http_parser.dart';


class PortionService {
  final String baseUrl = AppConfig.facPortionsUrl;
  final String accessToken = AppConfig.accessToken;

  Future<bool> postPortion(Map<String, dynamic> portionData, Uint8List? imageBytes, String? imageName, Uint8List? docBytes, String? docName) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..headers['Content-Type'] = 'multipart/form-data'
      ..fields.addAll({
    'standard': portionData['standard'],
    'academic_year': portionData['academic_year'],
    'subject': portionData['subject'],
    'unit': jsonEncode(portionData['unit']),  // Send as JSON
    'title': jsonEncode(portionData['title']),  // Send as JSON
    'description': portionData['description'],
    'reference': portionData['reference'],
    'last_updated': portionData['last_updated'],
});


   if (imageBytes != null && imageName != null) {
  request.files.add(http.MultipartFile.fromBytes(
    'image', imageBytes,
    filename: imageName,
    contentType: MediaType('image', imageName.split('.').last),
  ));
}

if (docBytes != null && docName != null) {
  request.files.add(http.MultipartFile.fromBytes(
    'document', docBytes,
    filename: docName,
    contentType: MediaType('application', docName.split('.').last),
  ));
}


    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

  print("Response Code: ${response.statusCode}");
  print("Response Body: $responseBody");

    return response.statusCode == 201;
  }
}
