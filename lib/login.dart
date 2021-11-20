import 'dart:convert';

import 'package:flutter_offirent/model/user.dart';
import 'package:flutter_offirent/public_offices/public_offices.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';






class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {

  bool _passwordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  String urlBase = 'https://api-e404.herokuapp.com/api/';


  void checkLogin() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    String? user = userPref.getString("email");

    if(user != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PublicOffices()), (route) => false);
    }
  }


  @override
  void initState() {
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                              controller: emailController,
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
                              controller: passController,
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
                                login();
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
      );
  }
  void login() async {
    if(emailController.text.isNotEmpty && passController.text.isNotEmpty){
      User user = User(username: emailController.text, password: passController.text);
      final String loginQuery = urlBase + "accounts/authenticate";

      http.Response response = await http.post(Uri.parse(loginQuery),
          body: user.userToJson(user),
          headers: {'Accept': 'application/json',
        "content-type":"application/json"}, );


      if(response.statusCode == 200){
        print("Reponse"+response.toString());
        final bodyResponse = jsonDecode(response.body);


        SharedPreferences userPrefs = await SharedPreferences.getInstance();
        await userPrefs.setString("email", bodyResponse["username"]);
        await userPrefs.setString("token", bodyResponse["token"]);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Usuario: ${bodyResponse["username"]}")));
        Navigator.of(context).pushReplacementNamed("/public_offices");
      }
      else{
        print("Credenciales invalidos");
        print(response.statusCode.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Credenciales inválidos")));
      }

    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No se han ingresado valores")));
    }

  }


}