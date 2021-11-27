import 'dart:ffi';

import 'package:flutter_offirent/db/favorites_database.dart';

class Office {
  int id=0;
  String address="";
  String image="";
  String name="";
  int floor=0;
  int capacity=0;
  bool allowResource = true;
  double score=0.0;
  String description="";
  double price=0.0;
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
    bool resourceBool;
    if (parsedJson['allowResource'] == 1) resourceBool = true;
    else resourceBool = false;

    bool statusBool;
    if (parsedJson['status'] == 1) statusBool = true;
    else statusBool = false;

    print(parsedJson['allowResource'].toString());
    this.id = parsedJson['id'];
    this.name = parsedJson['name'];
    this.image = parsedJson['image'];
    this.address = parsedJson['address'];
    this.floor = parsedJson['floor'];
    this.capacity = parsedJson['capacity'];
    this.allowResource = resourceBool;
    this.score = parsedJson['score'];
    this.description = parsedJson['description'];
    this.price = parsedJson['price'];
    this.status = statusBool;
    this.comment = parsedJson['comment'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'image': image,
      'name': name,
      'floor': floor,
      'capacity': capacity,
      'allowResource': allowResource,
      'score': score,
      'description': description,
      'price': price,
      'status': status,
      'comment': comment
    };
  }

}

