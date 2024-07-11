import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../models/locations_model.dart';
import '../screens/feeds_screen.dart';

class SearchFormWidget extends StatefulWidget {
  const SearchFormWidget({super.key});

  @override
  SearchFormWidgetState createState() {
    return SearchFormWidgetState();
  }
}

class SearchFormWidgetState extends State<SearchFormWidget> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  static const IconData search = IconData(0xf4a5, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);

  LocationsModel? locationsModel;

  void _getLocationsAutocomplete()async{
    var response = await http.get(Uri.parse("https://pxpropertyhub.com/api/v1/locations"));
    //print(response.body);
    setState(() {
      locationsModel = LocationsModel.fromJson(json.decode(response.body));
    });
  }

  void initState() {
    super.initState();
    _getLocationsAutocomplete();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Autocomplete<Data>(
        optionsBuilder: (TextEditingValue value){
          if(value.text.isEmpty){
            return List.empty();
          }
          return locationsModel!.data!
              .where((element) => element.cityTown!
              .toLowerCase()
              .contains(value.text.toLowerCase()))
              .toList();
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode node,
            Function onSubmit) =>
            TextFormField(
              controller: controller,
              focusNode: node,
              decoration: InputDecoration(
                  prefixIcon: Icon(search),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter the city then press enter key...",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  )
              ),
              style: TextStyle(color: Colors.indigo),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },

              onFieldSubmitted: (value){
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, proceed to the serach results screen
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: FeedsScreen(location: value))
                  );
                }
              },
            ),
        onSelected: (value) => print(value.cityTown),
        displayStringForOption: (Data d) => '${d.cityTown!}, ${d.country!}',
      ),
    );
  }
}