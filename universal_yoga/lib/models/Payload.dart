import 'dart:convert';

import 'package:universal_yoga/models/Bookings.dart';

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload {
  final String userId;
  final List<Bookings> bookingList;

  Payload({
    required this.userId,
    required this.bookingList,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      userId: json["userId"],
      bookingList: List<Bookings>.from(
          json["bookingList"].map((x) => Bookings.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "bookingList": List<dynamic>.from(bookingList.map((x) => x.toJson())),
      };
}
