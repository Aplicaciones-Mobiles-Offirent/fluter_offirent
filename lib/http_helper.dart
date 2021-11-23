

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offirent/model/office.dart';
import 'package:flutter_offirent/model/reservation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'model/account.dart';

const String urlBase = 'https://api-e404.herokuapp.com/api/';
class HttpHelper {



  Future<http.Response> loginFromAPI(TextEditingController email, TextEditingController password) async{

      final String loginQuery = urlBase + "accounts/authenticate";
      http.Response response = await http.post(Uri.parse(loginQuery),
          body:{
            "username": email.text,
            "password": password.text
          } );

      return response;

    }







  Future<List> getAllOffices() async {
    final String officesQuery = urlBase+'offices';
    http.Response response = await http.get(Uri.parse(officesQuery));

    if(response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List myOffices = jsonResponse.map((i) => Office.fromJson(i)).toList();
      return myOffices;
    } else {
      List myOffice =[];
      return myOffice;
    }

  }

  Future<List> getMyOffices(String emailProvider) async {
    final String myOfficesQuery = urlBase+'accounts/email/'+emailProvider+'/offices';
    http.Response response = await http.get(Uri.parse(myOfficesQuery));

    if(response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List myOffices = jsonResponse.map((i) => Office.fromJson(i)).toList();
      return myOffices;
    } else {
      print(response.statusCode);
      print(emailProvider);
      return null!;
    }

  }


  Future<Account> getAccount(String email) async {
    final String myAccountQuery = urlBase +'accounts/email/'+email;
    http.Response response = await http.get(Uri.parse(myAccountQuery));

    if(response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      Account account = Account.fromJson(jsonResponse);
      return account;
    } else {
      return null!;
    }
  }

  Future<Office> getOffice(int officeId) async {
    final String officeQuery = urlBase + 'offices/$officeId';
    http.Response response = await http.get(Uri.parse(officeQuery));

    if(response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      Office office = jsonResponse.map((i) => Office.fromJson(i));
      return office;
    } else {
      return null!;
    }

  }


  Future<List> getReservationsByEmail(String email) async {
    final String myReservationsQuery = urlBase + 'accounts/email/$email/reservations';
    http.Response response = await http.get(Uri.parse(myReservationsQuery));

    if(response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List reservations = jsonResponse.map((i) => Reservation.fromJson(i)).toList();
      return reservations;
    } else {
      return null!;
    }
  }

  Future<http.Response> deleteReservationByAccountIdAndReservationId(int accountId, int reservationId) async{
    final String myReservationQuery = urlBase + 'accounts/$accountId/reservations/$reservationId';
    http.Response response = await http.delete(Uri.parse(myReservationQuery));

    return response;

  }

}

Future<Account> getAccountWithoutClass(String email) async {
  final String myAccountQuery = urlBase +'accounts/email/'+email;
  http.Response response = await http.get(Uri.parse(myAccountQuery));

  if(response.statusCode == HttpStatus.ok) {
    /*final jsonResponse = json.decode(response.body);
    Account account = jsonResponse.map((i) => Account.fromJson(i)).ToAccount();*/
    print(response.statusCode);
    return accountFromJson(response.body);
    //print(email);
    //return account;
  } else {
    print(response.statusCode);
    print(email);
    return null!;
  }
}

Future<Office> getOfficeWithoutClass(int officeId) async {
  final String officeQuery = urlBase + 'offices/$officeId';
  http.Response response = await http.get(Uri.parse(officeQuery));

  if(response.statusCode == HttpStatus.ok) {
    final jsonResponse = json.decode(response.body);
    Office office = jsonResponse.map((i) => Office.fromJson(i));
    print(response.statusCode);
    return office;
  } else {
    print(response.statusCode);
    return null!;
  }

}