class District {
  int id=0;
  String name="";

  District(this.id,
            this.name);


  District.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.name = parsedJson['name'];
  }

}