import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/services/addAdvertisementsService.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/user.dart';

class AddAdvertisementPage extends StatefulWidget {
  @override
  _AddAdvertisementPage createState() => _AddAdvertisementPage();
}

class _AddAdvertisementPage extends State<AddAdvertisementPage> {
  AddAdvertisementsService addAdvertisementsService =
      new AddAdvertisementsService();
  final TextEditingController title = new TextEditingController();
  final TextEditingController description = new TextEditingController();
  final TextEditingController reward = new TextEditingController();
  String city;
  String category;
  String workingHour;
  String contractType;

  @override
  Widget build(BuildContext context) {
    User user;
    user = Provider.of<User>(context);

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
          padding: EdgeInsets.fromLTRB(40.0, 80.0, 40.0, 100.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add new Advertisement:',
                    style: Theme.of(context).textTheme.display4,
                  ),
                  textFormField(title, 'Title'),
                  textFormField(description, 'Description', maxLines: 10),
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
                            items: cities.map((String value) {
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
                            items: categories.map((String value) {
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
                            items: workingHours.map((String value) {
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
                            items: contractTypes.map((String value) {
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
                  textFormField(reward, 'Reward'),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text('Add'),
                    onPressed: () async {
                      try {
                        await addAdvertisementsService.addAdvertisement(
                            user,
                            title.text,
                            description.text,
                            category,
                            city,
                            workingHour,
                            contractType,
                            reward.text);
                        await Alert(
                          context: context,
                          title: "New advertisement added",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                        Navigator.pushReplacementNamed(context, '/catalog');
                      } catch (e) {
                        await Alert(
                          context: context,
                          title: "Upss... There is problem",
                          desc: e.toString().substring(11),
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }
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

  textFormField(TextEditingController controller, String text,
      {maxLines = 1, obscureText = false}) {
    return new TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: text,
      ),
      obscureText: obscureText,
    );
  }

  //todo - it wont change value of parameters!!!? flutter dont support that!?
  //create mutable object is only way?
  chooseFormField(String value, String name, List<String> list) {
    return new FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: name,
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: value == '',
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton<String>(
              value: value,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  value = newValue;
                  state.didChange(newValue);
                });
              },
              items: list.map((String value) {
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
        return val != '' ? null : 'Please select a ' + name;
      },
    );
  }
}
