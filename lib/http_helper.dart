import 'dart:html';

import 'package:flutter_offirent/model/office.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'model/account.dart';

class HttpHelper {
  final String urlBase = 'https://api-e404.herokuapp.com/api/';

  Future<List> getMyOffices(String emailProvider) async {
    final String myOfficesQuery = urlBase+'accounts/email/'+emailProvider+'/offices';
    http.Response response = await http.get(Uri.parse(myOfficesQuery));

    if(response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List myOffices = jsonResponse.map((i) => Office.fromJson(i)).toList();
      return myOffices;
    } else {
      return null!;
    }

  }


  Future<Account> getAccount(String email) async {
    final String myAccountQuery = urlBase +'accounts/email/'+email;
    http.Response response = await http.get(Uri.parse(myAccountQuery));

    if(response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      Account account = jsonResponse.map((i) => Account.fromJson(i));
      return account;
    } else {
      return null!;
    }
  }

}
