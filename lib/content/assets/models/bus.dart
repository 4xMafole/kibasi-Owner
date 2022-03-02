import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Bus {
  String busName;
  String plateNumber;
  String numberOfSeats;
  int pricePerSeat;
  String fromRegion;
  String toRegion;
  String busRoute;
  String departureTime;
  String arrivalTime;

  Bus({
    required this.busName,
    required this.plateNumber,
    required this.numberOfSeats,
    required this.pricePerSeat,
    required this.fromRegion,
    required this.toRegion,
    required this.busRoute,
    required this.departureTime,
    required this.arrivalTime,
  });

  Bus copyWith({
    String? busName,
    String? plateNumber,
    String? numberOfSeats,
    int? pricePerSeat,
    String? fromRegion,
    String? toRegion,
    String? busRoute,
    String? departureTime,
    String? arrivalTime,
  }) {
    return Bus(
      busName: busName ?? this.busName,
      plateNumber: plateNumber ?? this.plateNumber,
      numberOfSeats: numberOfSeats ?? this.numberOfSeats,
      pricePerSeat: pricePerSeat ?? this.pricePerSeat,
      fromRegion: fromRegion ?? this.fromRegion,
      toRegion: toRegion ?? this.toRegion,
      busRoute: busRoute ?? this.busRoute,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'busName': busName,
      'plateNumber': plateNumber,
      'numberOfSeats': numberOfSeats,
      'pricePerSeat': pricePerSeat,
      'fromRegion': fromRegion,
      'toRegion': toRegion,
      'busRoute': busRoute,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
    };
  }

  factory Bus.fromMap(Map<String, dynamic> map) {
    return Bus(
      busName: map['busName'] ?? '',
      plateNumber: map['plateNumber'] ?? '',
      numberOfSeats: map['numberOfSeats'] ?? '',
      pricePerSeat: map['pricePerSeat']?.toInt() ?? 0,
      fromRegion: map['fromRegion'] ?? '',
      toRegion: map['toRegion'] ?? '',
      busRoute: map['busRoute'] ?? '',
      departureTime: map['departureTime'] ?? '',
      arrivalTime: map['arrivalTime'] ?? '',
    );
  }

  factory Bus.fromSnapshot(DocumentSnapshot snapshot) {
    return Bus(
      busName: snapshot.get('busName'),
      plateNumber: snapshot.get('plateNumber'),
      numberOfSeats: snapshot.get('numberOfSeats'),
      pricePerSeat: snapshot.get('pricePerSeat'),
      fromRegion: snapshot.get('fromRegion'),
      toRegion: snapshot.get('toRegion'),
      busRoute: snapshot.get('busRoute'),
      departureTime: snapshot.get('departureTime'),
      arrivalTime: snapshot.get('arrivalTime'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bus.fromJson(String source) => Bus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Bus(busName: $busName, plateNumber: $plateNumber, numberOfSeats: $numberOfSeats, pricePerSeat: $pricePerSeat, fromRegion: $fromRegion, toRegion: $toRegion, busRoute: $busRoute, departureTime: $departureTime, arrivalTime: $arrivalTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bus &&
        other.busName == busName &&
        other.plateNumber == plateNumber &&
        other.numberOfSeats == numberOfSeats &&
        other.pricePerSeat == pricePerSeat &&
        other.fromRegion == fromRegion &&
        other.toRegion == toRegion &&
        other.busRoute == busRoute &&
        other.departureTime == departureTime &&
        other.arrivalTime == arrivalTime;
  }

  @override
  int get hashCode {
    return busName.hashCode ^
        plateNumber.hashCode ^
        numberOfSeats.hashCode ^
        pricePerSeat.hashCode ^
        fromRegion.hashCode ^
        toRegion.hashCode ^
        busRoute.hashCode ^
        departureTime.hashCode ^
        arrivalTime.hashCode;
  }
}
