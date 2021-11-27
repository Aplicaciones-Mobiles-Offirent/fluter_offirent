import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text("Perfil",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(onPressed: (){},
              icon: Icon(Icons.edit))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child:  Text("Juan Gómez",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            margin: EdgeInsets.all(15.0),
          ),
          Container(
            child: Image.network("https://cdn.pixabay.com/photo/2016/04/01/10/11/avatar-1299805_960_720.png",
              fit: BoxFit.fitHeight,
              height: 150,),
            margin: EdgeInsets.all(20.0),
          ),
          Container(
            child:  Text("Correo:",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.only(left: 10.0, top: 40.0),
          ),
          Container(
            child:  Text("juan.gomez@gmail.com",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.only(left: 10.0, top: 10.0),
          ),
          Container(
            child:  Text("Teléfono:",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.only(left: 10.0, top: 40.0),
          ),
          Container(
            child:  Text("+51 999 999 999",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.only(left: 10.0, top: 10.0),
          ),
          Container(
            child:  Text("Identificación:",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.only(left: 10.0, top: 40.0),
          ),
          Container(
            child:  Text("55555555",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            margin: EdgeInsets.only(left: 10.0, top: 10.0),
          ),
        ],
      ),
    );
  }
}