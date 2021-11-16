import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _passwordVisible = false;
  bool _cPasswordVisible = false;

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()
            {
              Navigator.of(context).pushNamed('/login');
            },
            icon: Icon(Icons.arrow_back),color: Colors.black,
          ),
          title: Text("Registrarse", style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white38,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formkey,
                      child: Container(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: "Usuario"
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return "Please enter some username ";
                                }
                                return null;
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.all(10)
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.email),
                                  hintText: "Email"
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return "Please enter email ";
                                }
                                if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9._]+.[a-z]").hasMatch(value)){
                                  return "Please enter a valid email ";
                                }
                                return null;
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.all(10)
                            ),
                            TextFormField(
                              controller: _password,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(Icons.visibility),
                                )
                              ),
                              keyboardType: TextInputType.emailAddress,
                              obscureText: !_passwordVisible,
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return "Please enter password ";
                                }
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.all(10)
                            ),
                            TextFormField(
                              controller: _confirmPassword,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  hintText: "Confirm Password",
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _cPasswordVisible = !_cPasswordVisible;
                                    });
                                  },
                                  icon: Icon(Icons.visibility),
                                )
                              ),
                              keyboardType: TextInputType.emailAddress,
                              obscureText: !_cPasswordVisible,
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return "Please enter re-password ";
                                }
                                if(_password.text != _confirmPassword.text){
                                  return "Password do not match";
                                }
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.all(25)
                            ),
                            MaterialButton(
                              height: 42,
                              minWidth: 250,
                              color: Colors.indigo,
                              textColor: Colors.white,
                              child: Text(
                                "Registrar",
                                style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
                              ),
                              onPressed: (){
                                if(_formkey.currentState!.validate()){
                                  Navigator.of(context).pushNamed('/login');
                                }

                              },
                              splashColor: Colors.indigoAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ],
                        ),
                      )
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
