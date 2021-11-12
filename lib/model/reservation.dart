import 'dart:convert';

Reservation reservationFromJson(String str) => Reservation.fromJson(json.decode(str));

class Reservation {
  int id;
  String accountEmail;
  int officeId;
  DateTime initialDate;
  DateTime endDate;

  Reservation(
    { required this.id,
      required this.accountEmail,
      required this.officeId,
      required this.initialDate,
      required this.endDate}
      );

  factory Reservation.fromJson(Map<String, dynamic> json){
    return Reservation(
        id: json['id'],
        accountEmail: json['accountEmail'],
        officeId: json['officeId'],
        initialDate: json['initialDate'],
        endDate: json['endDate']);
  }
}