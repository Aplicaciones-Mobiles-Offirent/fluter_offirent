import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Image(
                image: AssetImage("lib/assets/offi-rent.png"),
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.colorBurn,
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                      brightness: Brightness.light, primarySwatch: Colors.indigo,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          )
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: "Usuario"
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key),
                              labelText: "Contraseña"
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 40)
                        ),
                        MaterialButton(
                          height: 42,
                          minWidth: 250,
                          color: Colors.indigo,
                          textColor: Colors.white,
                          child: Text("Iniciar Sesión"),
                          onPressed: (){
                          },
                          splashColor: Colors.indigoAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
