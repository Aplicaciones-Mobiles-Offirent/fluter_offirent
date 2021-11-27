import 'package:flutter/material.dart';
import 'package:flutter_offirent/http_helper.dart';
import 'package:flutter_offirent/model/account.dart';
import 'package:flutter_offirent/widgets/drawer_widget.dart';

class Profile extends StatelessWidget {

  final String user;

  Profile(this.user);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title:  Text("Perfil",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed('/profile_config_view');
          },
              icon: Icon(Icons.edit))
        ],
      ),
      drawer: DrawerWidget(user: user),
      body: FutureBuilder<Account>(
          future: getAccountWithoutClass(user),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              return ListView(
                children: <Widget>[
                  Container(
                    child:  Text(snapshot.data!.firstName + " "+snapshot.data!.lastName,
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
                    child:  Text(snapshot.data!.email,
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
                    child:  Text(snapshot.data!.phoneNumber.toString(),
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
                    child:  Text(snapshot.data!.identification.toString(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 10.0, top: 10.0),
                  ),
                ],
              );
            }
            else {
              return  Center(child: CircularProgressIndicator(),);
            }
          })




    );
  }
}