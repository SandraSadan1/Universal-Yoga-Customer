import 'dart:convert';

class Bookings {
  final int instanceId;

  Bookings({
    required this.instanceId,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) {
    return Bookings(
      instanceId: json['instanceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instanceId': instanceId,
    };
  }
}
