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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.indigo
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Image.asset("lib/assets/usuario_generico.png")
                  ),
                  Text("Usuario"),
                  SizedBox(
                    height: 10.0,
                  )
                ],
              )
          ),
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
          SizedBox(height: 24,),
          Divider(color: Colors.white70,),
          SizedBox(height: 24),
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
    );
  }
}