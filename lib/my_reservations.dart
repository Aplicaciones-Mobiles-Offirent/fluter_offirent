

import 'package:flutter/material.dart';
import 'package:flutter_offirent/http_helper.dart';
import 'package:flutter_offirent/model/office.dart';
import 'package:flutter_offirent/widgets/drawer_widget.dart';


class MyReservations extends StatefulWidget {
  const MyReservations({Key? key}) : super(key: key);

  @override
  _MyReservationsState createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {

  late HttpHelper helper;
  int myReservationsCount=0;
  late List reservations;
  late String email = "flavio.s.m@gmail.com";
  late List offices;

  Future initialize() async{
    reservations = await helper.getReservationsByEmail(email);
    offices = await helper.getAllOffices();
    setState(() {
      myReservationsCount = reservations.length;
      reservations = reservations;
      offices = offices;
    });
  }


  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Reservaciones"),
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
          itemCount: (this.myReservationsCount == null) ? 0: this.myReservationsCount,
          itemBuilder: (BuildContext context, int position) {
            if(myReservationsCount == null)  {
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

                return Card(

                  color: Colors.white,
                  elevation: 4.0,
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      Container(
                        width: 150,
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
                              Text("Fecha inicio: "+reservations[position].initialDate.split("T")[0],
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,

                                ),
                                  textAlign: TextAlign.left
                              ),
                              SizedBox(height: 8,),
                              Text("Fecha fin: "+reservations[position].endDate.split("T")[0],
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
    );
  }
}
