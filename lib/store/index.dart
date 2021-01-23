import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:device_id/device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:foster_logger/pages/login.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class AppState extends ChangeNotifier {
  String _endpoint = 'http://kotari.online/api/v1/';
  String _url = 'http://kotari.online/';

  // String _endpoint = 'http://10.10.10.179/api/v1/';
  // String _url = 'http://10.10.10.179/';

  String _deviceId = '';
  String _token = '';
  Map _user;
  Map _foster;
  Map _weight;
  Map _feeding;
  SharedPreferences _sp;
  bool _sub = false;

  List _rooms = [];
  Map _filter = {};

  get rooms => _rooms;
  get filter => _filter;

  get url => _url;

  get deviceId => _deviceId;
  get endpoint => _endpoint;
  get user => _user;
  get foster => _foster;
  get weight => _weight;
  get feeding => _feeding;
  get token => _token;
  get sp => _sp;
  get sub => _sub;

  set rooms(value) {
    _rooms = value;
    notifyListeners();
  }

  set addRooms(value) {
    _rooms.add(value);
    notifyListeners();
  }

  set filter(value) {
    _filter = value;
    notifyListeners();
  }

  set sp(value) {
    _sp = value;
    notifyListeners();
  }

  set sub(value) {
    sub = value;
    notifyListeners();
  }

  set deviceId(value) {
    _deviceId = value;
    notifyListeners();
  }

  set token(value) {
    _token = value;
    notifyListeners();
  }

  set user(value) {
    _user = value;
    notifyListeners();
  }

  set foster(value) {
    _foster = value;
    notifyListeners();
  }

  set weight(value) {
    _weight = value;
    notifyListeners();
  }

  set feeding(value) {
    _feeding = value;
    notifyListeners();
  }

  AppState() {
//    this.getDeviceId();
    SharedPreferences.getInstance().then((data) {
      sp = data;
//      sp.clear();
      getUserFromStorage();
    });
  }

  void getUserFromStorage() {
    var result = this.sp.getString('user');
    var token = this.sp.getString('token');

    if (result != null) {
      var result2 = jsonDecode(result);
      this.user = result2;
    }

    if (token != null) {
      var token2 = jsonDecode(token);
      this.token = token2;
    }

//    print('done done');
  }

  void subP() {
    if (this.user['subscription'] != null) {
      if (this.user['subscription']['status'] == 0) {
        this.sub = true;
      }
    } else {
      this.sub = false;
    }
  }

  void setSubscription(value) {
    sub = value;
  }

//  Future<void> getDeviceId() async{
//    String device_id = await DeviceId.getID;
//    print(device_id);
//    this.deviceId=device_id;
//  }

  void notifyToast({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  void notifyToastDanger({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void notifyToastSuccess({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  Future<String> loadInterestJsonFile(String assetsPath) async {
    return rootBundle.loadString(assetsPath);
  }

  Future<http.Response> post(url, payload) async {
    var response =
        await http.post(this.endpoint + url, body: payload, headers: {
      "accept": "application/json",
    });

    return response;
  }

  Future<http.Response> postURL(url, payload) async {
    var response = await http.post(url, body: payload, headers: {
      "accept": "application/json",
    });

    return response;
  }

  Future<http.Response> postAuth(context, url, payload) async {
    var response = await http.post(this.endpoint + url,
        body: payload,
        headers: {
          "accept": "application/json",
          'Authorization': 'Bearer ' + this.token
        });

    print(response.statusCode);
    if (response.statusCode == 401) {
      // Navigator.push(context,
      //     new MaterialPageRoute(builder: (context) => new LoginPage()));
    }
    if (response.statusCode == 422) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      Map<String, dynamic> errors = resp['errors'];
      this.notifyToastDanger(
          context: context, message: errors.values.toList()[0][0]);
    }
    return response;
  }

  Future<http.Response> get(url, {context}) async {
    var response = await http.get(url, headers: {"accept": "application/json"});
    if (response.statusCode == 401 && context != null) {
      // Navigator.push(context,
      //     new MaterialPageRoute(builder: (context) => new LoginPage()));
    }

    return response;
  }

  String formatDate(date) {
    return date.toString().split(' ')[0];
  }

  String formatTime(time) {
    return time.toString().split(':')[0] + ':' + time.toString().split(':')[1];
  }
}
