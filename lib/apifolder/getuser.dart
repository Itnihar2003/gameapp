import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static const String baseUrl =
      'https://1823-2409-40e2-17-14f9-147c-562-de01-b02c.ngrok-free.app/api/users';

  // Method to get user by Firebase UID
  static Future<Map<String, dynamic>?> getUser(String firebaseUid) async {
    final String url = '$baseUrl/user/$firebaseUid';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return responseData['user'];
      } else {
        print('Failed to load user data: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  // Method to create a new batch with sub-batches
  static Future<Map<String, dynamic>?> createBatch({
    required String batchName,
    required List<Map<String, dynamic>> subBatches, // List of sub-batches
    required String creatorId, // ID of the creator
    required String description, // Description of the batch
  }) async {
    const String url =
        'https://1823-2409-40e2-17-14f9-147c-562-de01-b02c.ngrok-free.app/api/users/createBatch'; // Replace with your actual URL

    // Creating the body for the POST request
    Map<String, dynamic> body = {
      'name': batchName,
      'subBatches': subBatches,
      'creatorId': creatorId, // Include the creator ID
      'description': description, // Include the description
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);
        return responseData; // Assuming the response returns batch info
      } else {
        print('Failed to create batch: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error creating batch: $e');
      return null;
    }
  }

  // Method to get all batches created by a specific user (creatorId)
  static Future<List<Map<String, dynamic>>?> getAllBatches(
      String creatorId) async {
    final String url =
        '$baseUrl/getBatches/$creatorId'; // Endpoint to fetch all batches created by the user

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(responseData['batches']);
      } else {
        print('Failed to fetch batches: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching batches: $e');
      return null;
    }
  }

  // Method to get user by _id
  static Future<Map<String, dynamic>?> getUserById(String userId) async {
    final String url =
        '$baseUrl/userById/$userId'; // Endpoint to fetch user by _id

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return responseData['user'];
      } else {
        print('Failed to load user data: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data by _id: $e');
      return null;
    }
  }

  // Method to get user details (name, playerType) by user IDs in sub-batch
  static Future<List<Map<String, dynamic>>?> getUserDetailsInSubBatch(
      List<String> userIds) async {
    final String url =
        '$baseUrl/getUserDetailsInSubBatch'; // Endpoint to get user details from the batch

    // Creating the body for the POST request
    Map<String, dynamic> body = {
      'userIds': userIds, // List of user IDs
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(responseData['users']);
      } else {
        print('Failed to fetch user details: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching user details in sub-batch: $e');
      return null;
    }
  }
}
