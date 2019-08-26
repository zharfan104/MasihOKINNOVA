import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masihokeh/main.dart';
import 'package:masihokeh/services/usermanagement.dart';

bool loading = false;

class SignupScreen extends StatefulWidget {
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const SignupScreen(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.yellow, fontSize: 24.0),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => Signup();
}

class Signup extends State<SignupScreen> {
  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController controllernamadepan = TextEditingController();
  TextEditingController controllernamabelakang = TextEditingController();
  TextEditingController controlleremail = TextEditingController();
  TextEditingController controllernohp = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  String namadepan;
  String namabelakang;
  String email;
  String noHP;
  String password;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        body: SafeArea(
            child: new SingleChildScrollView(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "MasihOK",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "pacifico",
                            fontSize: 48.0),
                      ),
                      Text(
                        "Jadilah Penyelamat Makanan!",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "futuras",
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                height: 35.0,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: new Row(
                  children: <Widget>[
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {
                        Application.router.navigateTo(context, "/login",
                            transition: TransitionType.fadeIn);
                      },
                      child: new Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {},
                      child: new Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              new SafeArea(
                  top: false,
                  bottom: false,
                  child: Card(
                      elevation: 5.0,
                      child: Form(
                          key: formKey,
                          autovalidate: _autovalidate,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(height: 8.0),
                                  TextFormField(
                                    onSaved: (val) {
                                      namadepan = val;
                                    },
                                    controller: controllernamadepan,
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        icon: Icon(
                                          Icons.person,
                                          color: Colors.black38,
                                        ),
                                        hintText: 'Enter first name',
                                        labelText: 'First Name',
                                        labelStyle:
                                            TextStyle(color: Colors.black54)),
                                    keyboardType: TextInputType.text,
                                    validator: (val) => val.length < 1
                                        ? 'Enter first name'
                                        : null,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    onSaved: (val) {
                                      namabelakang = val;
                                    },
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        icon: Icon(
                                          Icons.perm_identity,
                                          color: Colors.black38,
                                        ),
                                        hintText: 'Enter last name',
                                        labelText: 'Last Name',
                                        labelStyle:
                                            TextStyle(color: Colors.black54)),
                                    keyboardType: TextInputType.text,
                                    validator: (val) => val.length < 1
                                        ? 'Enter last name'
                                        : null,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    onSaved: (val) {
                                      email = val;
                                    },
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        icon: Icon(
                                          Icons.email,
                                          color: Colors.black38,
                                        ),
                                        hintText: 'Your email address',
                                        labelText: 'E-mail',
                                        labelStyle:
                                            TextStyle(color: Colors.black54)),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    onSaved: (val) {
                                      noHP = val;
                                    },
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        icon: Icon(
                                          Icons.phone_android,
                                          color: Colors.black38,
                                        ),
                                        hintText: 'Your phone number',
                                        labelText: 'Phone',
                                        labelStyle:
                                            TextStyle(color: Colors.black54)),
                                    keyboardType: TextInputType.phone,
                                    validator: validateMobile,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    onSaved: (val) {
                                      password = val;
                                    },
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid),
                                        ),
                                        icon: Icon(
                                          Icons.lock,
                                          color: Colors.black38,
                                        ),
                                        hintText: 'Your password',
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(color: Colors.black54)),
                                    validator: (val) => val.length < 6
                                        ? 'Password too short.'
                                        : null,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Center(
                                    child: new Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            onPressed: () {
                                              _submit();
                                            },
                                            color: Colors.blueGrey,
                                            child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "openbold"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  /*   const SizedBox(height:24.0),
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: (){
                                  },
                                  child: Text('FORGOT PASSWORD?',style: TextStyle(
                                    color: Colors.blueAccent,fontSize: 13.0
                                  ),),
                                ),
                                new GestureDetector(
                                  onTap: (){
                                  },
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.orange,fontSize: 15.0
                                  ),),
                                ),
                              ],
                            )
*/
                                ]),
                          )) //login,
                      ))
            ],
          ),
        )));
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length < 8)
      return 'Mobile Number must be more than 8 digit, now you have${value.length} digit ';
    else
      return null;
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _onLoading();
    } else {
      showInSnackBar('Please fix the errors in red before submitting.');
    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void _onLoading() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new CircularProgressIndicator(),
            ),
            new Text("Loading"),
          ],
        ),
      ),
    );
    _performLogin();
  }

  _performLogin() async {
    // This is just a demo, so no actual login here.

    DataDiri data = DataDiri(
        email: email,
        password: password,
        namabelakang: namabelakang,
        namadepan: namadepan,
        noHP: noHP);
    return UserManagement().storeNewUser(data, context);
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}

class DataDiri {
  final String namadepan;
  final String namabelakang;
  final String noHP;
  final String email;
  final String password;

  DataDiri(
      {this.namadepan,
      this.namabelakang,
      this.noHP,
      this.email,
      this.password});
}
