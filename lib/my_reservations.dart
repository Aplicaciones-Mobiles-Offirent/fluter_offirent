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
                  child: ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(office.image),
                    ),
                    title: Text(office.name),
                    subtitle: Text('Fecha inicio: '+reservations[position].initialDate.toString() + '  - Fecha fin: '+reservations[position].endDate.toString()),
                  ),
                );
            }
        },
      ),
    );
  }
}
