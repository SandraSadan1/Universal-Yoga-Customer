import 'dart:convert';

import 'package:universal_yoga/models/Bookings.dart';

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload {
  final String userId;
  final List<Bookings> bookingList;
  final String b2;

  Payload({required this.userId, required this.bookingList, required this.b2});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      userId: json["userId"],
      b2: json["b2"],
      bookingList: List<Bookings>.from(
          json["bookingList"].map((x) => Bookings.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "b2": b2,
        "bookingList": List<dynamic>.from(bookingList.map((x) => x.toJson())),
      };
}
