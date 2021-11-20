class Account {
  int id=0;
  String email="";
  String password="";
  String identification="";
  int accType=0;
  String firstName="";
  String lastName="";
  String phoneNumber="";
  bool isPremium=true;
  
  Account(this.id,
          this.email,
          this.password,
          this.identification,
          this.accType,
          this.firstName,
          this.lastName,
          this.phoneNumber,
          this.isPremium);

   Account.fromJson(Map<String, dynamic> parseJson){
    this.id = parseJson['id'];
    this.email = parseJson['email'];
    this.password = parseJson['password'];
    this.identification = parseJson['identification'];
    this.accType = parseJson['accType'];
    this.firstName = parseJson['firstName'];
    this.lastName = parseJson['lastName'];
    this.phoneNumber = parseJson['phone'];
    this.isPremium = parseJson['premium'];
  }


}