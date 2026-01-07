import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<bool> postAbsensi({
    required File foto,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/absensi');

      var request = http.MultipartRequest('POST', uri);

      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();

      request.files.add(
        await http.MultipartFile.fromPath(
          'foto',
          foto.path,
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('STATUS CODE: ${response.statusCode}');
      print('RESPONSE BODY: $responseBody');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('ERROR API: $e');
      return false;
    }
  }
  static List<Map<String, dynamic>> riwayatAbsensi = [];
}
