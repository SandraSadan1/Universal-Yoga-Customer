import 'dart:async';
import 'dart:convert';

import 'package:universal_yoga/models/Courses.dart';
import 'package:http/http.dart' as http;
import 'package:universal_yoga/models/Payload.dart';

class ApiService {
  Future<List<Courses>> getInstances() async {
    final response = await http.get(
        Uri.parse('https://mock.apidog.com/m1/416237-0-default/getInstances'));

    if (response.statusCode == 200) {
      final List body = json.decode(response.body);

      return body.map((e) => Courses.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch courses');
    }
  }

  Future<String> bookCourse(Payload payload) async {
    final response = await http.post(
      Uri.parse('https://mock.apidog.com/m1/416237-0-default/getInstances'),
      body: payload,
    );

    if (response.statusCode == 200) {
      return "Courses booked Successfully";
    } else {
      throw Exception('Failed to book course');
    }
  }
}
