import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.indigo,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            DrawerHeader(
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
                        Text("Correo de Usuario",
                          style: TextStyle(fontSize: 14),),
                      ],
                    )
                  ],
                )
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
                Navigator.of(context).pushNamed('/public_offices');
              },
            ),
            ListTile(
              leading: Icon(Icons.home_work),
              title: Text("Mis Locales"),
              onTap: () {
                Navigator.of(context).pushNamed('/public_offices');
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
                Navigator.of(context).pushNamed('/public_offices');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Cerrar sesión"),
              onTap: () {
                Navigator.of(context).pushNamed('/public_offices');
              },
            ),
          ],
        ),
      ),
    );
  }
}