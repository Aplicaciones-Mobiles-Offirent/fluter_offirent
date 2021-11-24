import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/reservation.dart';


class ReservationPage extends StatefulWidget{

  final int officeId;

  const ReservationPage({
     Key? key,
    required this.officeId,
}): super(key:key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

//String accountEmail = "";
//late int officeId;

Future<http.Response> createReservation(String accountEmail, int officeId, String startDate, String endDate) async{


  final String apiUrl = 'https://api-e404.herokuapp.com/api/accounts/email/$accountEmail/Office=$officeId/reservations';
  final reservationBody =json.encode({
    "initialDate": startDate.toString(),
    "endDate": endDate.toString()
  });

  final response = await http.post(Uri.parse(apiUrl), body: reservationBody,
    headers: {"content-type":"application/json"}, );
    return response;

}


class _ReservationPageState extends State<ReservationPage> {
  String startDateText = "Not selected.";
  String endDateText = "Not selected.";
  String initialDateTextToApi ="";
  String endDateTextToApi ="";
  late DateTime startDate;
  late DateTime endDate;
  late String accountEmail;


  void getCred() async{
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      accountEmail = userPrefs.getString("email")!;
    });
  }

  changeDateText(int type, DateTime time) {
    String hourToString = time.hour.toString();
    int hour = time.hour;
    String minuteToString = time.minute.toString();
    int minute = time.minute;
    String dayToString = time.day.toString();
    int day = time.day;
    String monthToString = time.month.toString();
    int month = time.month;

    int year = time.year;
    String yearToString = year.toString();

    setState(() {
      if (type == 1){
        //  if(minute)
        if(day < 10){
          dayToString = "0"+time.day.toString();
        }
        if(month < 10){
          monthToString = "0"+time.month.toString();
        }
        if(hour < 10){
          hourToString = "0"+time.hour.toString();
        }
        if(minute < 10){
          minuteToString = "0"+time.minute.toString();
        }
        startDateText = dayToString + "/" + monthToString + " at " + hourToString + ":" + minuteToString;
        initialDateTextToApi = yearToString + "-" + monthToString + "-" + dayToString + "T" + hourToString + ":" + minuteToString + ":00.000+00:00";

      } else {
        if(day < 10){
          dayToString = "0"+time.day.toString();
        }
        if(month < 10){
          monthToString = "0"+time.month.toString();
        }
        if(hour < 10){
          hourToString = "0"+time.hour.toString();
        }
        if(minute < 10){
          minuteToString = "0"+time.minute.toString();
        }
        endDateText = "to " + dayToString + "/" + monthToString + " at " + hourToString + ":" + minuteToString;
        endDateTextToApi = yearToString + "-" + monthToString + "-" + dayToString + "T" + hourToString + ":" + minuteToString + ":00.000+00:00";
      }
    });
  }


  createConfirmDialog(){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Reserva exitosa!"),
        content: Text("La reserva de esta oficina se realizó exitosamente."
            " Puede visualizarla en la pestaña Mis Reservas"),
        actions: [
          TextButton(
              onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil("/my_reservations",
                          ModalRoute.withName("/public_offices"));
                },
              child: Text("Ver Mis Reservas")),
          TextButton(
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/public_offices', (Route<dynamic> route) => false);
              },
              child: Text("Ok")),

        ],
      );
    },);
  }

  errorDialog(){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Ha ocurrido un error!"),
        content: Text("Ocurrió un error inesperado en el servidor, vuelva a intentarlo maás tarde"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Ok")),

        ],
      );
    },);
  }

  void createReservationWithUserInterface(String starDate, String endDate) {
    createReservation(accountEmail, widget.officeId, starDate, endDate).then((response) {
      if(response.statusCode == 200)
        {
          createConfirmDialog();
          print(response.body);
          print(response.statusCode);


        }
      else{
        print(accountEmail);
        print(starDate);
        print(endDate);
        print(response.statusCode);
        errorDialog();

      }

    }).catchError((error){
      print("error: $error");});

  }

  @override
  void initState() {
    getCred();
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
          appBar: AppBar(
            title: Text("Hacer una Reservacion"),
            backgroundColor: Colors.indigo,
          ),
          body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 70),
              children: [
                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Elige un rango de fechas",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row (
                        children: [
                          TextButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2020, 3, 5),
                                  maxTime: DateTime(2022, 6, 7),
                                  onChanged: (date) {
                                    startDate = date;
                                    print('change $startDate');
                                  },
                                  onConfirm: (date) {
                                    startDate = date;
                                    changeDateText(1, startDate);
                                    print(startDateText);
                                    print('confirm $startDate');
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: const Text ('Escoger fecha inicio',
                                style: TextStyle(
                                    fontSize: 13)
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 50),
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  )
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                            ),
                          ),
                          Text(startDateText,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,),)
                        ],
                      ),
                  ),
                Padding(padding: const EdgeInsets.only(top: 16),
                    child: Row (
                      children: [
                        TextButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2020, 3, 5),
                                maxTime: DateTime(2022, 6, 7),
                                onChanged: (date) {
                                  endDate = date;
                                  print('change $endDate');
                                },
                                onConfirm: (date) {
                                  endDate = date;
                                  changeDateText(2, endDate);
                                  print('confirm $endDate');
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: const Text ('Escoger fecha final',
                              style: TextStyle(
                                  fontSize: 13)
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(horizontal: 50),
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                          ),
                        ),
                        Text(endDateText,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            )),
                      ],
                    ),
                ),
                Padding(padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: SizedBox(
                        width: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            createReservationWithUserInterface(initialDateTextToApi, endDateTextToApi);
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(horizontal: 50),
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                            ),
                            //foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.tealAccent)
                          ),

                          child: const Text ('Crear Reservacion',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black)
                          ),
                        )
                    ),
                )
            ],
            ))
      );
  }
}