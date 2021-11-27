
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateOfficePage extends StatefulWidget {
  const CreateOfficePage({Key? key}) : super(key: key);

  @override
  _CreateOfficePageState createState() => _CreateOfficePageState();
}

class _CreateOfficePageState extends State<CreateOfficePage> {

  late String accountEmail;

  void getCred() async{
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      accountEmail = userPrefs.getString("email")!;
    });
  }

  File? sampleImage;

  late String _nameOfficeValue;
  late String _descriptionOfficeValue;
  late String _addressOfficeValue;
  late int _capacityOfficeValue;
  late double _priceOfficeValue;
  late String url;
  final formKey = GlobalKey<FormState>();

  /////////////

  final int districtId = 1;
  final int floor = 0;
  final bool allowResource = true;
  final double score = 0.0;
  final bool status = true;
  final String comment= "";

  ///////////////

  Future<http.Response> createOffice(String name, String image, String description, String address, int capacity, double price ) async {
    final String apiUrl = 'https://api-e404.herokuapp.com/api/accounts/email/$accountEmail/District=$districtId/offices';
    final officeBody = json.encode({
      "address": address,
      "name": name,
      "image": image,
      "floor": floor,
      "capacity": capacity,
      "allowResource": allowResource,
      "score": score,
      "description": description,
      "price": price,
      "status": status,
      "comment": comment
    });

    final response = await http.post(Uri.parse(apiUrl), body: officeBody,
    headers: {"content-type":"application/json"}, );
    return response;
  }

  void createOfficeWithUserInterface(String name, String image, String description, String address, int capacity, double price){
    createOffice(name, image, description, address, capacity, price).then((response) {
      if(response.statusCode == 200)
      {

        print(response.body);
        print(response.statusCode);


      }
      else{
      print(accountEmail);
      print(name);
      print(description);
      print(address);
      print(capacity);
      print(price);
      print(response.statusCode);
      }

    }).catchError((error) {
      print("");
    });
  }


  @override
  void initState() {
    getCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creación de Oficina"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Imagen de la oficina:"),
                    SizedBox(width: 80,),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:  MaterialStateProperty.all<Color>(Colors.indigo)
                        ),
                        onPressed: (){
                          getImage();
                        },
                        child: Text("Subir imagen"))
                  ],
                ),
                SizedBox(height: 50,),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        sampleImage == null ? Text("Selecciona una imagen")
                            : enableUpload(),
                        SizedBox(height: 30.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Nombre"
                          ),
                          validator: (value){
                            return value!.isEmpty ? "Nombre es requerido":null;
                          },
                          onSaved: (value){
                            setState(() {
                              _nameOfficeValue = value!;
                            });
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Descripción"
                          ),
                          validator: (value){
                            return value!.isEmpty ? "Descripción es requerida":null;
                          },
                          onSaved: (value){
                            setState(() {
                              _descriptionOfficeValue = value!;
                            });
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Dirección"
                          ),
                          validator: (value){
                            return value!.isEmpty ? "Dirección es requerida":null;
                          },
                          onSaved: (value){
                            setState(() {
                              _addressOfficeValue = value!;
                            });
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Aforo"
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value){
                            return value!.isEmpty ? "Aforo es requerido":null;
                          },
                          onSaved: (value){
                            setState(() {
                              final intNumber = int.tryParse(value!);
                              _capacityOfficeValue = intNumber!;
                            });
                          },
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Precio"
                          ),
                            keyboardType: TextInputType.number,
                          validator: (value){
                            return value!.isEmpty ? "Precio es requerido":null;
                          },
                          onSaved: (value){
                            setState(() {
                              final doubleNumber = double.tryParse(value!);
                                _priceOfficeValue = doubleNumber!;
                            });
                          },
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                        ),
                        SizedBox(height: 15.0),
                        ElevatedButton(
                          child: Text("Crear Oficina"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.tealAccent)
                          ),
                          onPressed: (){
                            uploadStatusImage();
                          },
                        )
                      ],
                    )),

              ],
            ),
          )

        ),
      )
    );
  }

  void uploadStatusImage() async {
    if(validateAndSave()) {

      //Imagen Subida a Firebase Storage
      final Reference officeImageRef = 
          FirebaseStorage.instance.ref().child("Office Images");
      var timeKey = DateTime.now();
      final UploadTask uploadTask =
        officeImageRef.child(timeKey.toString()+".png").putFile(sampleImage!);
      uploadTask.whenComplete(() async {
        try{
          url = await officeImageRef.getDownloadURL().toString();
          print("Image url: "+ url);

        }catch(onError){
          print("Error");
        }

      });

      createOfficeWithUserInterface(_nameOfficeValue, url, _descriptionOfficeValue, _addressOfficeValue, _capacityOfficeValue, _priceOfficeValue);

      /////// Future de la api para crear Oficina

      Navigator.of(context).pushNamed("/provider_offices");
    }
  }

  bool validateAndSave(){
    final form= formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future getImage() async {
    var tempImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
    var imageFile = File(tempImage!.path);
    setState(() {
      sampleImage = imageFile;
    });
  }

  Widget enableUpload(){
    return Image.file(
      sampleImage!,
      height: 300.0,
      width: 600.0,
    );
  }
}
