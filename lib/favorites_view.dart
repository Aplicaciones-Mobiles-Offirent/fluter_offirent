import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_offirent/db/favorites_database.dart';
import 'package:flutter_offirent/widgets/drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoritesPage extends StatefulWidget {

  @override
  _FavoritesPageState createState() => _FavoritesPageState();

}

class _FavoritesPageState extends State<FavoritesPage> {

  String emailProvider="";
  List favorites = [];

  confirmDeleteDialog(){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Oficina eliminada"),
        content: Text("Se eliminó la oficina seleccionada de la lista de Favoritos"),
        actions: [
          TextButton(
              onPressed: (){
                //Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil("/favorite_offices",
                    ModalRoute.withName("/public_offices"));
              },
              child: Text("Ok")),
        ],
      );
    }, barrierDismissible: false);
  }

  Future initialize() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    emailProvider = userPrefs.getString("email")!;
    favorites = await DatabaseHelper.instance.getFavorites();
    print(favorites);
    setState(() {
      print(favorites);
      emailProvider = emailProvider;
      favorites = favorites;
    });
  }

  void getCred() async {    //funcion como modelo, si se quita no hay diferencia
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      emailProvider = userPrefs.getString("email")!;
    });
  }

  @override
  void initState() {
    getCred();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
          appBar: AppBar(
            title: Text("Mis Favoritos"),
            backgroundColor: Colors.indigo,
          ),
          drawer: DrawerWidget(user: emailProvider,),
          body: SafeArea(
            child: ListView.builder(
              itemCount: (favorites.length == null) ? 0: favorites.length,
              itemBuilder: (context, index){
                if(this.favorites.length == 0) {
                  return Card(
                    color: Colors.white,
                    elevation: 4.0,
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(),
                      title: Text("No posees ninguna oficina"),
                    ),
                  );
                } else {
                  return Card(
                    color: Colors.white,
                    elevation: 4.0,
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(this.favorites[index].image),
                      ),
                      trailing: TextButton.icon(
                          icon: Icon(Icons.cancel_rounded),
                          label: const Text("",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),),
                          onPressed: () => {
                            setState(() {
                              DatabaseHelper.instance.remove(this.favorites[index].id);
                            }),
                            confirmDeleteDialog()
                          }
                      ),
                      title: Text(favorites[index].name),
                      subtitle: Text('Score:'+ favorites[index].score.toString() + ' - Precio: S/.' + favorites[index].price.toString()+'0'),
                    ),
                  );
                }
              },
            ),)
      );

  }
}
