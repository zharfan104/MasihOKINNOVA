import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:masihokeh/main.dart';
import 'package:fluro/fluro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masihokeh/services/usermanagement.dart';

class LoginScreen extends StatefulWidget {
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const LoginScreen(
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
  State<StatefulWidget> createState() => Login();
}

class Login extends State<LoginScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    prefrences = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    print(isLoggedIn);
    if (isLoggedIn) {
      Application.router.navigateTo(context, "/landing");
    }
    setState(() {
      loading = false;
    });
  }

  Future<FirebaseUser> _handleSignIn() async {
    prefrences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final FirebaseUser user =
        (await firebaseAuth.signInWithCredential(credential)).user;
    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance.collection("users").document(user.uid).setData({
          "id": user.uid,
          "profilePicture": user.photoUrl,
          "nama": user.displayName,
          "email": user.email,
          "masihokeh": false
        });

        await prefrences.setString("id", user.uid);
        await prefrences.setString("nama", user.displayName);
        await prefrences.setString("email", user.email);
        await prefrences.setString("photourl", user.photoUrl);
        await prefrences.setBool("masihokeh", false);
      } else {
        await prefrences.setString("id", documents[0]['id']);
        await prefrences.setString("nama", documents[0]['nama']);
        await prefrences.setString("email", documents[0]['email']);
        await prefrences.setString("photourl", documents[0]['profilePicture']);
        await prefrences.setBool("masihokeh", documents[0]['masihokeh']);
      }
      Fluttertoast.showToast(msg: "Login Berhasil");
      setState(() {
        loading = false;
      });
      Application.router.navigateTo(context, "/landing");
    } else {}
    return user;
  }

  ShapeBorder shape;
  SharedPreferences prefrences;
  bool loading = false;
  bool isLoggedIn = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    isSignedIn();
  }

  String email;
  String password;

  bool _autovalidate = false;
  bool formWasEdited = false;

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
              Visibility(
                visible: loading ?? true,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.grey),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: new Row(
                  children: <Widget>[
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {
                        /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));*/
                      },
                      child: new Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {
                        Application.router.navigateTo(context, "/signup",
                            transition: TransitionType.fadeIn);
                      },
                      child: new Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black26,
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
                                  const SizedBox(height: 10.0),
                                  TextFormField(
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
                                    validator: (val) => !val.contains('@')
                                        ? 'Not a valid email.'
                                        : null,
                                    onSaved: (val) => email = val,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
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
                                    onSaved: (val) => password = val,
                                  ),
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  new Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Container(
                                          alignment: Alignment.bottomLeft,
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: new GestureDetector(
                                            onTap: () {},
                                            child: Text(
                                              'FORGOT PASSWORD?',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 13.0),
                                            ),
                                          ),
                                        ),
                                        new MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          onPressed: () {
                                            _submit();
                                          },
                                          color: Colors.blueGrey,
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "openbold"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    height: 50.0,
                                    child: SignInButton(
                                      Buttons.Google,
                                      text: "Log in with Google",
                                      onPressed: () {
                                        _handleSignIn();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    height: 50.0,
                                    child: SignInButton(
                                      Buttons.Facebook,
                                      text: "Log in with Facebook",
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(height: 22.0),
                                ]),
                          )) //login,
                      ))
            ],
          ),
        )));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to email and password fields.
      print("asu");
      _performLogin();
    } else {
      showInSnackBar('Please fix the errors in red before submitting.');
    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void _performLogin() async {
    try {
      FirebaseUser user = await UserManagement().signIn(email, password);
      Application.router.navigateTo(context, "/");
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Email/Password Salah atau Akun Tidak Ada",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.grey.withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
