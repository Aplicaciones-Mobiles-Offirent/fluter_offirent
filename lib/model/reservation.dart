class Reservation{
  int id=0;
  bool status = false;
  DateTime initialDate=DateTime.utc(2000,11,15);
  DateTime endDate=DateTime.utc(2000,11,16);
  int officeId=0;

  Reservation(this.id,
              this.initialDate,
              this.endDate,
              this.status,
              this.officeId);

  Reservation.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.status = parsedJson['status'];
    this.initialDate = parsedJson['initialDate'];
    this.endDate = parsedJson['endDate'];
    this.officeId = parsedJson['officeId'];
  }
}