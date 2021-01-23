import 'package:flutter/material.dart';
import 'package:foster_logger/pages/landingpage.dart';
import 'package:foster_logger/store/data_notifier.dart';
import 'package:provider/provider.dart';
import 'package:foster_logger/store/index.dart';
import 'package:flutter_automation/flutter_automation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppState()),
        ChangeNotifierProvider(
          create: (_) => DataNotifier(),
        ),
      ],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          // primaryColor: Color.fromRGBO(88, 51, 254, 1.0),
          primaryColor: Color.fromRGBO(65, 114, 183, 1.0),
          // primaryColor: Colors.grey[200],
          accentColor: Colors.grey[100],

          // Define the default font family.
          fontFamily: 'OpenSans',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(65, 114, 183, 1.0),
              fontFamily: 'OpenSans',
            ),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            headline5: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(65, 114, 183, 1.0),
              fontFamily: 'OpenSans',
            ),
            headline4: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(65, 114, 183, 1.0),
              fontFamily: 'OpenSans',
            ),
            bodyText2: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(65, 114, 183, 1.0),
              fontFamily: 'OpenSans',
            ),
            bodyText1: TextStyle(
              fontSize: 18.0,
              color: Color.fromRGBO(65, 114, 183, 1.0),
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        home: new LandingPage(),
      )));
}
//debugPrint('notification payload: ' + payload);
