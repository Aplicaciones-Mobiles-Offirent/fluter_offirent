import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:http/http.dart' as http;

import 'model/reservation.dart';



class ReservationPage extends StatefulWidget{

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

String accountEmail = "";
late int officeId;

Future<Reservation?> createReservation(String accountEmail, int officeId, String startDate, String endDate) async{


  final String apiUrl = 'https://api-e404.herokuapp.com/api/accounts/email/$accountEmail/Office=$officeId/reservations';

  final response = await http.post(Uri.parse(apiUrl), body: {
      "initialDate": startDate.toString(),
      "endDate": endDate.toString()
  });

  if (response.statusCode == 200){
    final String responseString = response.body;

    return reservationFromJson(responseString);
  }else {
    return null;
  }
}


class _ReservationPageState extends State<ReservationPage> {
  String startDateText = "Not selected.";
  String endDateText = "Not selected.";
  String initialDateTextToApi ="";
  String endDateTextToApi ="";
  late DateTime startDate;
  late DateTime endDate;

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
        initialDateTextToApi = yearToString + "-" + monthToString + "-" + dayToString + "T" + hourToString + ":" + minuteToString + "00.000+00:00";

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
        endDateTextToApi = yearToString + "-" + monthToString + "-" + dayToString + "T" + hourToString + ":" + minuteToString + "00.000+00:00";
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
          appBar: AppBar(
            title: Text("Hacer una Reservacion"),
          ),
          body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 75),
              children: [
                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Make a Reservation",
                      style: TextStyle(
                        fontSize: 30,
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
                            child: const Text ('Select Start Date',
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
                          child: const Text ('Select End Date',
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
                Padding(padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                        width: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            createReservation(accountEmail, officeId, initialDateTextToApi, endDateTextToApi);
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
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                          ),
                          child: const Text ('Create Reservation',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white)
                          ),
                        )
                    ),
                )
            ],
            ))
      );
  }
}