import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:masihokeh/pages/logind_signup.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new LoginScreen(),
        title: new Text(
          'Selamat Datang\n Di masihOK',
          style: TextStyle(
              color: Colors.black, fontFamily: 'pacifico', fontSize: 32.0),
        ),
        image: new Image.asset('assets/logo masihok.png'),
        backgroundColor: Colors.black.withOpacity(0.01),
        styleTextUnderTheLoader: new TextStyle(
          color: Colors.black,
          fontFamily: 'pacifico',
        ),
        photoSize: 100.0,
        loaderColor: Colors.black);
  }
}

class IntroPage extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: Colors.black.withOpacity(0.3),
        bubble: Image.asset('assets/ibis.png'),
        body: Text(
          'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
        ),
        title: Text(
          'Flights',
          style: TextStyle(color: Colors.black, fontFamily: 'pacifico'),
        ),
        textStyle: TextStyle(fontFamily: 'alegreyaR', color: Colors.black),
        mainImage: Image.asset(
          'assets/ibis.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: Colors.black.withOpacity(0.3),
      iconImageAssetPath: 'assets/ibis.png',
      body: Text(
        'We  work  for  the  comfort ,  enjoy  your  stay  at  our  beautiful  hotels',
      ),
      title: Text(
        'Hotels',
        style: TextStyle(color: Colors.black, fontFamily: 'pacifico'),
      ),
      mainImage: Image.asset(
        'assets/t-shirt-model.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'alegreyaR', color: Colors.black),
    ),
    PageViewModel(
      pageColor: Colors.black.withOpacity(0.3),
      iconImageAssetPath: 'assets/ibis.png',
      body: Text(
        'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
      ),
      title: Text(
        'Cabs',
        style: TextStyle(color: Colors.black, fontFamily: 'pacifico'),
      ),
      mainImage: Image.asset(
        'assets/warungpintar.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'alegreyaR', color: Colors.black),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      onTapDoneButton: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ), //MaterialPageRoute
        );
      },
      pageButtonTextStyles: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );
  }
}
