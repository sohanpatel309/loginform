import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
//import 'package:dio/dio.dart';
//import './model/user.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    theme: ThemeData(
       // brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var cities = ['Gwalior', 'Bhind', 'Morena',"chhatarpur","datiya"];
  final double _minimumPadding = 5.0;

  var _currentCitySelected = '';

  @override
  void initState() {
    super.initState();
    _currentCitySelected = cities[0];
  }

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilenoController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Ragistration Form'),
      ),

      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                //getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: textStyle,
                      controller: firstnameController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter first name';
                        }
                      },

                      decoration: InputDecoration(
                          labelText: 'Firstname',
                          hintText: 'Enter firstname e.g. sohan',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: textStyle,
                      controller: lastnameController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter last name';
                        }
                      },

                      decoration: InputDecoration(
                          labelText: 'last name',
                          hintText: 'Enter firstname e.g. patel',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: textStyle,
                      controller: emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        }
                      },

                      decoration: InputDecoration(
                          labelText: 'email',
                          hintText: 'e.g. patelsohan@gmail.com',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter phone';
                        }
                      },

                      decoration: InputDecoration(
                          labelText: 'mobile no',
                          hintText: 'e.g. 7440519273',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: textStyle,
                              controller: mobilenoController,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter Age';
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Age',
                                  hintText: 'Age eg. 24 ',
                                  labelStyle: textStyle,
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 15.0
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                              items: cities.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _currentCitySelected,
                              onChanged: (String newValueSelected) {
                                // Your code to execute, when a menu item is selected from dropdown
                                _onDropDownItemSelected(newValueSelected);
                              },
                            ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Submit',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  _calculateTotalReturns();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

 /* Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }*/

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentCitySelected = newValueSelected;
    });
  }

 /* String _calculateTotalReturns() {

    double firstname = double.parse(firstnameController.text);
    double lastname = double.parse(lastnameController.text);
    double email = double.parse(emailController.text);
    double mobileno = double.parse(mobilenoController.text);
    double age = double.parse( ageController.text);

   /* double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;*/
   return "sohan";
  }*/

   _calculateTotalReturns () async{
    print("bjhbgjksdfjkgsdfjkgnjksdfngjksdnfg");
    var firstname  = firstnameController.text;
    var lastname = lastnameController.text;
    var email = emailController.text;
    var mobileno = mobilenoController.text;
    var age = ageController.text;
    var dio = new Dio();
    FormData formData = new FormData.from({
      "firstname": firstname,
      "lastname":lastname,
      "email": email,
      "phone": mobileno,
      "age": age,
    });
     Response response1 = await dio.post("http://192.168.0.200/sohan/Ondoor/index.php/test/insertdata", data: formData);
    print("------->"+response1.toString());

  }

  void _reset() {
    firstnameController.text = '';
    lastnameController.text = '';
    emailController.text = '';
    mobilenoController.text = '';
   ageController.text = '';

    _currentCitySelected = cities[0];
  }
}