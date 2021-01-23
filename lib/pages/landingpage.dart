import 'package:flutter/material.dart';
import 'package:foster_logger/pages/houseList.dart';
import 'package:foster_logger/store/data_notifier.dart';
import 'package:provider/provider.dart';
import 'package:foster_logger/store/index.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  _LandingPage createState() => new _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  AppState state;

  void initState() {
    super.initState();

    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    state = Provider.of<AppState>(context, listen: false);
//      state.sp.clear();
    Future.delayed(Duration(seconds: 1), () {
      // print(state.user);
      // if (state.user == null) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => new LoginPage()));
      // } else {
      //   print('options');
      getItems(state.endpoint + "getHouseList");
      // Navigator.of(context).pop();

      // }
    });
  }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIOverlays(
  //       [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Stack(
          children: [
            new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: new Image.asset(
                      'assets/images/mark.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // new Text(
                  //   "Kotari",
                  //   style: TextStyle(
                  //     fontSize: 60,
                  //     // fontWeight: FontWeight.bold,
                  //     color: Colors.lightBlue,
                  //   ),
                  // ),
                  new Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    // height: 50,
                    child: LinearProgressIndicator(
                      minHeight: 2,
                      backgroundColor: Colors.lightBlue,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getItems(url) {
    var filter = Provider.of<DataNotifier>(context, listen: false).houseFilter;
    state.postURL(url, filter).then((data) {
      var body = jsonDecode(data.body);
      print(body);
      if (data.statusCode == 422) {
        Map<String, dynamic> response = jsonDecode(data.body);
        Map<String, dynamic> errors = response['errors'];
        state.notifyToastDanger(
            context: context, message: errors.values.toList()[0][0]);
      } else if (data.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new HouseList(data: body['houses'])));
      } else {
        state.notifyToastDanger(
            context: context, message: "Error occured while getting data");
      }
    }).catchError((error) {
      print(error);
    });
  }
}
