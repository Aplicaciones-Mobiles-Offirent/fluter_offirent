import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image(
                      image: AssetImage("lib/assets/offi-rent.png"),
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.colorBurn,
                    height: 185,
                    ),
                  Padding(
                      padding: EdgeInsets.all(10)
                      ),
                  Text(
                    "Inicia sesión",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
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
                                  labelText: "Email"
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            Padding(
                                padding: EdgeInsets.all(5)
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.vpn_key),
                                  labelText: "Contraseña",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(Icons.visibility),
                                )
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: !_passwordVisible,

                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 38)
                            ),
                            MaterialButton(
                              height: 42,
                              minWidth: 250,
                              color: Colors.indigo,
                              textColor: Colors.white,
                              child: Text(
                                  "Iniciar Sesión",
                                style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
                              ),
                              onPressed: (){
                                Navigator.of(context).pushNamed('/public_offices');
                              },
                              splashColor: Colors.indigoAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top:45)
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("¿Aún no estás registrado?"),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/register');
                                  },
                                  child: Text(
                                    " Registrarse",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}