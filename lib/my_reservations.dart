

import 'package:flutter/material.dart';
import 'package:flutter_offirent/http_helper.dart';
import 'package:flutter_offirent/model/office.dart';
import 'package:flutter_offirent/widgets/drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyReservations extends StatefulWidget {
  const MyReservations({Key? key}) : super(key: key);

  @override
  _MyReservationsState createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {

  late HttpHelper helper;
  int myReservationsCount=0;
  late List reservations;
  late String email = "flavio1.s.m@gmail.com";
  late List offices;


  Future initialize() async{
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    email = userPrefs.getString("email")!;
    reservations = await helper.getReservationsByEmail(email);
    offices = await helper.getAllOffices();

    setState(() {
      email = email;
      myReservationsCount = reservations.length;
      reservations = reservations;
      offices = offices;
    });
  }

  void getCred() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      email = userPrefs.getString("email")!;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    getCred();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Reservaciones"),
      ),
      drawer: DrawerWidget(user: email,),
      body: ListView.builder(
          itemCount: (this.myReservationsCount == null) ? 0: this.myReservationsCount,
          itemBuilder: (BuildContext context, int position) {
            if(myReservationsCount <= 0)  {
              return Card(
                color: Colors.white,
                elevation: 4.0,
                child: ListTile(
                  onTap: () {},
                  leading: CircleAvatar(),
                  title: Text("No tienes ninguna reservacion"),
                ),
              );
            } else {
              final temporalOfficeId = reservations[position].officeId;
              Office office = offices.firstWhere((element) => element.id == reservations[position].officeId);
              final reservationInitialDateOutputComplete = reservations[position].initialDate.toString().split(".")[0];
              final  String reservationInitialDateOutputDate = reservationInitialDateOutputComplete.split("T")[0];
              final String reservationInitialDateOutputHourComplete = reservationInitialDateOutputComplete.split("T")[1];
              final reservationInitialDateOutputHourList = reservationInitialDateOutputHourComplete.split(":");
              final String reservationInitialDateOutputToUser = reservationInitialDateOutputDate + " a las "+ reservationInitialDateOutputHourList[0]+":"+reservationInitialDateOutputHourList[1];


              final reservationEndDateOutputComplete = reservations[position].endDate.toString().split(".")[0];
              final  String reservationEndDateOutputDate = reservationEndDateOutputComplete.split("T")[0];
              final String reservationEndDateOutputHourComplete = reservationEndDateOutputComplete.split("T")[1];
              final reservationEndDateOutputHourList = reservationEndDateOutputHourComplete.split(":");
              final String reservationEndDateOutputToUser = reservationEndDateOutputDate + " a las "+ reservationEndDateOutputHourList[0]+":"+reservationEndDateOutputHourList[1];


                return Card(

                  color: Colors.white,
                  elevation: 4.0,
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        height: 180,
                        child: Image.network(office.image,
                                  fit: BoxFit.fitHeight )
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                office.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold
                                ),
                                  textAlign: TextAlign.left
                              ),
                              SizedBox(height: 13,),
                              Text("Inicio: "+reservationInitialDateOutputToUser,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,

                                ),
                                  textAlign: TextAlign.left
                              ),
                              SizedBox(height: 8,),
                              Text("Fin: "+reservationEndDateOutputToUser,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 13,),
                              ButtonBar(

                                children:[
                                  TextButton(
                                    onPressed: () {},
                                    child: Text("Eliminar")),
                                  ElevatedButton(
                                      onPressed: (){},
                                      child: Text("Ver"))]

                              ),

                            ],
                          ),
                      )
                    ],
                  ),
                );
            }
        },
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          child: Icon(
            Icons.add,
            ),
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.of(context).pushNamed('/create_reservation');
          }),
    );
  }
}
