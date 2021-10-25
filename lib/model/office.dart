import 'dart:ffi';

class Office {
  int id;
  String address;
  int floor;
  int capacity;
  bool allowResource;
  Float score;
  String description;
  Float price;
  bool status;
  String comment;

  Office(this.id,
      this.address,
      this.floor,
      this.capacity,
      this.allowResource,
      this.score,
      this.description,
      this.price,
      this.status,
      this.comment );

}
