import 'dart:convert';

Reservation reservationFromJson(String str) => Reservation.fromJson(json.decode(str));

class Reservation {
  int id;
  bool status;
  int officeId;
  String initialDate;
  String endDate;

  Reservation(
      { required this.id,
        required this.status,
        required this.officeId,
        required this.initialDate,
        required this.endDate}
      );

  factory Reservation.fromJson(Map<String, dynamic> json){
    return Reservation(
        id: json['id'],
        status: json['status'],
        officeId: json['officeId'],
        initialDate: json['initialDate'],
        endDate: json['endDate']);
  }


}