import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:universal_yoga/models/Courses.dart';
import 'package:http/http.dart' as http;
import 'package:universal_yoga/models/Payload.dart';
import 'package:universal_yoga/utils/Constants.dart';

class ApiService {
  Future<List<Courses>> getInstances() async {
    Map<String, String> payload = HashMap();
    payload["userid"] = CONSTANTS().userId;
    payload["b2"] = "Submit";

    final response = await http.post(
        Uri.parse(
            'https://stuiis.cms.gre.ac.uk/COMP1424CoreWS/comp1424cw/GetInstances'),
        body: payload);
    // https://mock.apidog.com/m1/416237-0-default/getInstances
    // https://stuiis.cms.gre.ac.uk/COMP1424CoreWS/comp1424cw/GetInstances
    // https://mock.apidog.com/m1/416237-0-default/getInstances

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
      Uri.parse('https://stuiis.cms.gre.ac.uk/COMP1424CoreWS/comp1424cw/SubmitBookings'),
      body: payload,
    );
    // https://stuiis.cms.gre.ac.uk/COMP1424CoreWS/comp1424cw/SubmitBookings
    // https://mock.apidog.com/m1/416237-0-default/SubmitBookings

    if (response.statusCode == 200) {
      return "Courses booked Successfully";
    } else {
      throw Exception('Failed to book course');
    }
  }
}
