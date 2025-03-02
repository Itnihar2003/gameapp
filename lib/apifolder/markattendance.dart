import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceService {
  static const String _baseUrl =
      'http://wswogwcs08gcw4c840s8wwsw.152.70.67.68.sslip.io/api/users';

  // Function to mark attendance
  static Future<Map<String, dynamic>?> markAttendance(
      String firebaseUid, double latitude, double longitude) async {
    const String url = '$_baseUrl/markAttendance';
    Map<String, String> headers = {"Content-Type": "application/json"};

    Map<String, dynamic> body = {
      "firebaseUid": firebaseUid,
      "latitude": latitude,
      "longitude": longitude,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to mark attendance: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error marking attendance: $e');
      return null;
    }
  }
}
