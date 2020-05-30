import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/widgets/navbar.dart';

import 'catalog.dart';

class FilterAdvertisementPage extends StatefulWidget {
  @override
  _FilterAdvertisementPage createState() => _FilterAdvertisementPage();
}

class _FilterAdvertisementPage extends State<FilterAdvertisementPage> {
  String city;
  String category;
  String workingHour;
  String contractType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bck.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color.fromRGBO(255, 255, 255, 0.5), BlendMode.modulate),
          ),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(40.0, 100.0, 40.0, 100.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Filtering Advertisements:',
                    style: Theme.of(context).textTheme.display4,
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: "City",
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: city == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: city,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                city = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: emptyCities.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Category",
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: category == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: category,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                category = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: emptyCategories.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Working Hours",
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: workingHour == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: workingHour,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                workingHour = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: emptyWorkingHours.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (val) {
                      return val != '' ? null : 'Please select a Working Hours';
                    },
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Contract Type",
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: contractType == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: contractType,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                contractType = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: emptyContractTypes.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text('Show Advertisements'),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Catalog(
                                  workingHour: workingHour,
                                  contractType: contractType,
                                  city: city,
                                  category: category)));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
