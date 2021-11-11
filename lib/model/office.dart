import 'dart:ffi';

class Office {
  int id=0;
  String address="";
  String image="";
  String name="";
  int floor=0;
  int capacity=0;
  bool allowResource = true;
  Float score=0 as Float;
  String description="";
  Float price=0 as Float;
  bool status= true;
  String comment="";

  Office(this.id,
      this.address,
      this.name,
      this.image,
      this.floor,
      this.capacity,
      this.allowResource,
      this.score,
      this.description,
      this.price,
      this.status,
      this.comment );


  Office.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.name = parsedJson['name'];
    this.image = parsedJson['image'];
    this.address = parsedJson['address'];
    this.floor = parsedJson['floor'];
    this.capacity = parsedJson['capacity'];
    this.allowResource = parsedJson['allowResource'];
    this.score = parsedJson['score'];
    this.description = parsedJson['description'];
    this.price = parsedJson['price'];
    this.status = parsedJson['status'];
    this.comment = parsedJson['comment'];
  }

}
