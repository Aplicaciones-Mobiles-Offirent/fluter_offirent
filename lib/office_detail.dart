import 'package:flutter/material.dart';

class OfficeDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title:  Text("Información de la oficina",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.indigo,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: const Text("OFICINA",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: Image.network("https://cdn.pixabay.com/photo/2015/05/15/14/22/conference-room-768441_960_720.jpg",
                  fit: BoxFit.cover),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: const Text("Correo: offi@hotmail.com",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: const Text("Telefono: +51 985 265 412",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: MaterialButton(
                  color: Colors.tealAccent,
                  child: const Text("Alquilar local S/.390",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),),
                  onPressed: (){}),
              margin: EdgeInsets.all(10.0),
            ),
            TextButton.icon(
                icon: Icon(Icons.favorite),
                label: const Text("Agregar a favoritos",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),),
                onPressed: (){}),
          ],
        ),
      );

  }
}