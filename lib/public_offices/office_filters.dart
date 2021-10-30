import 'package:flutter/material.dart';


class OfficeFilters extends StatefulWidget {



  final String filterChange;

  const OfficeFilters({Key? key, required this.filterChange}) : super(key: key);

  @override
  State<OfficeFilters> createState() => _OfficeFiltersState();
}


class District {
  int id;
  String name;

  District(this.id, this.name);

  static List<District> getDistricts() {
    return <District>[
      District(1, "San Miguel" ),
      District(2, "Surco" ),
      District(3, "Magdalena" ),
      District(4, "San Isidro" ),
    ];
  }
}


class _OfficeFiltersState extends State<OfficeFilters> {

  List<District> _districts = District.getDistricts();
  late List<DropdownMenuItem<District>> _dropDownMenuItems;
  late District _selectedDistrict;


  @override
  void initState() {
      _dropDownMenuItems = buildDropDownMenuItems(_districts);
      _selectedDistrict = _dropDownMenuItems[0].value!;

  }


  String onFilterChange(String change){
    change = filterC;
    return change;
  };

  List<DropdownMenuItem<District>> buildDropDownMenuItems(List districts) {
    List<DropdownMenuItem<District>> items = [];
    
    for(District district in districts){
      items.add(DropdownMenuItem(
        value: district,
        child: Text(district.name),
            )
          );
        }

      return items;

  }

  onChangeDropDownItem(District selectedDistrict) {
    setState(() {
      _selectedDistrict = selectedDistrict;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text("Escoge un distrito"),
          Spacer(),
          DropdownButton(
            value: _selectedDistrict,
            items: _dropDownMenuItems,
            onChanged: (District? value) {
              _selectedDistrict = value!;

              setState(() {

               });
              },

           ),
          TextButton(
              child: Text("KDSFJHG"),
              onPressed: () {
                onFilterChange("sdf");
              },
          )

         ],
        ),
      );
    }

}


