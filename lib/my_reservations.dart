
import 'package:flutter/material.dart';
import 'package:flutter_offirent/http_helper.dart';
import 'package:flutter_offirent/model/office.dart';
import 'package:flutter_offirent/widgets/drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/account.dart';


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
  late Account account;


  confirmDeleteDialog(int accountId, int reservationId){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Cancelar Reserva"),
        content: Text("¿Estas seguro de cancelar su Reserva?"),
        actions: [
          TextButton(
              onPressed: (){
                //Navigator.of(context).pop();
                deleteReservation(accountId, reservationId);
                Navigator.of(context).pushNamedAndRemoveUntil('/my_reservations', (Route<dynamic> route) => false);
              },
              child: Text("Si")),
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("No")),

        ],
      );
    },);
  }

  deleteReservation(int accountId, int reservationId) {
    helper.deleteReservationByAccountIdAndReservationId(accountId, reservationId).then((response) {

      if(response.statusCode == 200){
        print("Se eliminó correctamente");
        print("ID de Reserva eliminada: $reservationId");

      }
      else{
        print(accountId);
        print(reservationId);
        print(response.statusCode);
      }
    }).catchError((error){
      print("error: $error");});
  }


  Future initialize() async{
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    email = userPrefs.getString("email")!;
    account = await helper.getAccount(email);
    reservations = await helper.getReservationsByEmail(email);
    offices = await helper.getAllOffices();

    setState(() {
      email = email;
      account = account;
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
          itemCount: (myReservationsCount == null) ? 0: myReservationsCount,
          itemBuilder: (BuildContext context, int position) {
            if(myReservationsCount == 0)  {
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
                        child: AspectRatio(
                            aspectRatio: 130.0 / 180.0,
                            child: FadeInImage(
                                placeholder: AssetImage('lib/assets/loading.gif'),
                                image: NetworkImage(office.image),
                                    fit: BoxFit.fitHeight ),
                          ),
                      )/*Image.network(office.image,
                                  fit: BoxFit.fitHeight )*/
                      ,
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
                                    onPressed: () {
                                      confirmDeleteDialog(account.id, reservations[position].id);
                                    },
                                    child: Text("Cancelar")),
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

    );
  }
}
