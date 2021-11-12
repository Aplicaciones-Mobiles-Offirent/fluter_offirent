import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:http/http.dart' as http;

import 'model/reservation.dart';

void main() {
  runApp(ReservationPage());
}

class ReservationPage extends StatefulWidget{

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

String accountEmail = "";
late int officeId;

Future<Reservation?> createReservation(String accountEmail, int officeId, DateTime startDate, DateTime endDate) async{

  final String apiUrl = "https://api-mobil.herokuapp.com/api/accounts/email/$accountEmail/$officeId/reservations";

  final response = await http.post(apiUrl, body: {
      "startDate": startDate,
      "endDate": endDate
  });

  if (response.statusCode == 201){
    final String responseString = response.body;

    return reservationFromJson(responseString);
  }else {
    return null;
  }
}


class _ReservationPageState extends State<ReservationPage> {
  String startDateText = "Not selected.";
  String endDateText = "Not selected.";
  late DateTime startDate;
  late DateTime endDate;

  changeDateText(int type, DateTime time) {
    String hour = time.hour.toString();
    String minute = time.minute.toString();
    String day = time.day.toString();
    String month = time.month.toString();

    setState(() {
      if (type == 1){
        startDateText = day + "/" + month + " at " + hour + ":" + minute;
      } else {
        endDateText = "to " + day + "/" + month + " at " + hour + ":" + minute;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      home: Scaffold(
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
                                    fontSize: 18)
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
                              fontSize: 18,
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
                                  fontSize: 18)
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
                              fontSize: 18,
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
                            createReservation(accountEmail, officeId, startDate, endDate);
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
      ),
    );
  }
}