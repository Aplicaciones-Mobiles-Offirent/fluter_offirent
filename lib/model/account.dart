


import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

class Account {
  int id;
  String email;
  String password;
  String identification;
  int accType;
  String firstName;
  String lastName;
  int phoneNumber;
  bool isPremium;
  
  Account(
      {required this.id,
      required this.email,
      required this.password,
      required this.identification,
      required this.accType,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.isPremium}
    );

   factory Account.fromJson(Map<String, dynamic> parsedJson){
     return Account(
         id: parsedJson['id'],
         email: parsedJson['email'],
         password: parsedJson['password'],
         identification: parsedJson['identification'],
         accType: parsedJson['accType'],
         firstName: parsedJson['firstName'],
         lastName: parsedJson['lastName'],
         phoneNumber: parsedJson['phone'],
         isPremium: parsedJson['premium']);
   }


}