import 'package:flutter/material.dart';
import 'package:flutter_offirent/http_helper.dart';
import 'package:flutter_offirent/model/district.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderCreateOffices extends StatefulWidget {
  @override
  _ProviderCreateOfficesState createState() => _ProviderCreateOfficesState();
}

class _ProviderCreateOfficesState extends State<ProviderCreateOffices> {

  late HttpHelper helper;
  late String account;
  late SharedPreferences sharedPreferences;
  late List districts;
  int _value = 1;
  late List<DropdownMenuItem<int>> _menuItems = [];

  final TextEditingController _nameController  = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  Future initilize() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    account = userPrefs.getString("email")!;
    districts = await helper.getAllDistricts();
    _menuItems = List.generate(
      districts.length,
          (i) => DropdownMenuItem(
            value: int.parse(districts[i]["id"]),
            child: Text("${districts[i]["name"]}"),
      ),
    );
    print(_menuItems);
  }
  @override
  void initState() {
    // TODO: implement initState
    initilize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Crear nueva oficina'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: "Nombre",
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Dirección",
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _floorController,
                decoration: const InputDecoration(
                  labelText: "Pisos",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(
                  labelText: "Capacidad",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _scoreController,
                decoration: const InputDecoration(
                  labelText: "Puntuación",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descripcion",
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: "Precio",
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: "Comentario",
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: "Imagen",
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8.0),
              DropdownButton<int>(
                items: _menuItems,
                value: _value,
                onChanged: (value) => setState(() => _value = value!),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
