

import 'dart:convert';

class User {
  String username;
  String password;

 User(
    { required this.username,
    required this.password}
    );

 Map<String, dynamic> toJson() => {
   "username":username,
   "password":password
 };

 String userToJson(User data){
   final dyn = data.toJson();
   return json.encode(dyn);
 }

}