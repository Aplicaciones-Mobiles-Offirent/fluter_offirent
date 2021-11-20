import 'package:flutter/material.dart';
import 'package:flutter_offirent/model/account.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_offirent/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class DrawerWidget extends StatefulWidget {
  
  final String user;


  const DrawerWidget({
    Key? key,
    required this.user


  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String username="";

  Future<void> getCred() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
       username = userPrefs.getString("email")!;
       username = username;
    });

  }


  @override
  void initState() {
    super.initState();
    getCred();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.indigo,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            FutureBuilder<Account>(

              future: getAccountWithoutClass(widget.user),
              builder: (context, snapshot){

                if (snapshot.hasData) {
                  // return something
                  return Text("${snapshot.data!.email}");
                } else if (snapshot.hasError) {
                  // Manage error
                  print(snapshot.error.toString());
                  return Text(snapshot.error.toString());
                } else {
                  // return something for the user to wait
                }


                return DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.indigo
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius:40,
                            backgroundImage: NetworkImage("https://img2.freepng.es/20180331/eow/kisspng-computer-icons-user-clip-art-user-5abf13db298934.2968784715224718991702.jpg")
                        ),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 45.0,),
                            Text("Usuario",
                              style: TextStyle(fontSize: 20),),
                            SizedBox(height: 4.0,),
                            Text('Correo',
                              style: TextStyle(fontSize: 13),),
                          ],
                        )
                      ],
                    )
                );
              }

            ),
            Divider(
              //height: 40,
              color: Colors.white30,
              thickness: 4,
              indent: 0,
              endIndent: 00,),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Oficinas"),
              onTap: () {
                Navigator.of(context).pushNamed('/public_offices');
              },
            ),
            ListTile(
              leading: Icon(Icons.today),
              title: Text("Mis Reservas"),
              onTap: () {
                Navigator.of(context).pushNamed('/my_reservations');
              },
            ),
            ListTile(
              leading: Icon(Icons.home_work),
              title: Text("Mis Locales"),
              onTap: () {
                Navigator.of(context).pushNamed('/provider_offices');
              },
            ),

            Divider(
              height: 100,
              color: Colors.white30,
              thickness: 2,
              indent: 20,
              endIndent: 20,),

            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text("Perfil"),
              onTap: () {
                Navigator.of(context).pushNamed('/profile_config_view');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Cerrar sesión"),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}