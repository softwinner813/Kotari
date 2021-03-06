import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foster_logger/pages/galley_view.dart';
import 'package:foster_logger/pages/roomList.dart';
import 'package:foster_logger/store/data_notifier.dart';
import 'package:provider/provider.dart';
import 'package:foster_logger/store/index.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:getwidget/getwidget.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:multiselect_formfield/multiselect_formfield.dart';

class RoomFilter extends StatefulWidget {
  RoomFilter({Key key, this.house}) : super(key: key);
  final house;
  @override
  _RoomFilter createState() => new _RoomFilter();
}

class _RoomFilter extends State<RoomFilter> {
  AppState state;
  String error = '';
  bool status = false;
  Color color = Colors.green.withOpacity(0.6);
  List items = [];
  String nextPage = '';
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<String> _matchDropList = [
    'none',
    'Dhiffushi',
    'Himmafushi',
    'Hulhumalé',
    'Huraa',
    'Malé',
    'Thulusdhoo',
    'Villingili',
    'Gulhi',
    'Guraidhoo',
    'Maafushi',
    'Gaafaru',
    'Kaashidhoo'
  ];
  List<String> _reviwText = ['Good', 'Very good', 'Excellent', 'Exceptional'];

  SfRangeValues _budget = SfRangeValues(0.0, 10000.0);

  String _islandDropDown;

  List _roomOffer;
  String _roomOfferResult;

  List _facility;
  String _facilityResult;

  Map data;

  void initState() {
    super.initState();
    state = Provider.of<AppState>(context, listen: false);

    _roomOffer = [];
    _roomOfferResult = '';
    _facility = [];
    _facilityResult = '';
    setState(() {
      _islandDropDown = _matchDropList[0];
    });

    // getItems(state.endpoint +
    //     "get-foster-weight/" +
    //     state.foster['id'].toString() +
    //     "?token=" +
    //     state.token);
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = AppBar().preferredSize.height;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Color mainColor = Theme.of(context).primaryColor;
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: new Text(
          'Room Filter',
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: new SafeArea(
        child: SingleChildScrollView(
          child: new Container(
            width: MediaQuery.of(context).size.width,
            height: (width > height)
                ? 500
                : MediaQuery.of(context).size.height - 2 * appHeight,
            // margin: EdgeInsets.only(top: 20),
            // padding: EdgeInsets.only(bottom: 85),
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(15),
            child: new Column(
              mainAxisAlignment: (width > height)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceAround,
              children: <Widget>[
                //============= Budget ================
                Padding(padding: EdgeInsets.only(top: 30)),
                GFTypography(
                  text: 'Budget:',
                  type: GFTypographyType.typo3,
                  showDivider: false,
                ),
                Container(
                  child: SfRangeSlider(
                    min: 0.0,
                    max: 10000.0,
                    values: _budget,
                    interval: 2000.0,
                    showTicks: true,
                    showLabels: true,
                    showTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        _budget = values;
                      });
                    },
                  ),
                ),

                //============= Room offers ================
                Padding(padding: EdgeInsets.only(top: 30)),
                MultiSelectFormField(
                  autovalidate: false,
                  chipBackGroundColor: Color.fromRGBO(0, 153, 0, 1.0),
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blueAccent,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Room offers:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  dataSource: [
                    {
                      "display": "Breakfast include",
                      "value": "breakfast",
                    },
                    {
                      "display": "Kid friendly",
                      "value": "kid",
                    },
                    {
                      "display": "Pet friendly",
                      "value": "pet",
                    },
                    {
                      "display": "Air condition",
                      "value": "air",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  initialValue: _roomOffer,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _roomOffer = value;
                    });
                  },
                ),

                //============= Facility Options ================

                Padding(padding: EdgeInsets.only(top: 30)),
                MultiSelectFormField(
                  autovalidate: false,
                  chipBackGroundColor: Color.fromRGBO(0, 153, 0, 1.0),
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blueAccent,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Facilities:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  dataSource: [
                    {
                      "display": "Free internet",
                      "value": "internet",
                    },
                    {
                      "display": "Water pool",
                      "value": "pool",
                    },
                    {
                      "display": "Fitness Center",
                      "value": "fitness",
                    },
                    {
                      "display": "Free Parking",
                      "value": "park",
                    },
                    {
                      "display": "Restaurant",
                      "value": "restaurant",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  initialValue: _facility,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _facility = value;
                    });
                  },
                ),

                Padding(padding: EdgeInsets.only(top: 30)),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  width: double.infinity,
                  child: ButtonTheme(
                    minWidth: 50.0,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blueAccent)),
                    child: RaisedButton(
                      elevation: 5.0,
                      hoverColor: Colors.green,
                      color: mainColor,
                      child: (status)
                          ? new CircularProgressIndicator(
                              backgroundColor: Colors.blueAccent,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2)
                          : new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ),
                                Padding(padding: EdgeInsets.only(left: 3)),
                                Text(
                                  "FILTER",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                      onPressed: () {
                        search();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => new RoomFilter()));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void search() {
    var sendData = {
      'minBudget': _budget.start.toString(),
      'maxBudget': _budget.end.toString(),
    };
    for (var room in _roomOffer) {
      sendData['room_' + room] = room;
    }

    for (var facility in _facility) {
      sendData['facility_' + facility] = facility;
    }

    String sort = Provider.of<DataNotifier>(context, listen: false).sort;
    sendData['sort'] = sort;

    sendData['house_id'] = widget.house['id'].toString();
    //Save RoomFilter Data
    Provider.of<DataNotifier>(context, listen: false)
        .updateRoomFilter(sendData);

    setState(() {
      status = true;
    });

    state.post('roomFilter', sendData).then((data) {
      var body = jsonDecode(data.body);
      if (data.statusCode == 422) {
        Map<String, dynamic> response = jsonDecode(data.body);
        Map<String, dynamic> errors = response['errors'];
        state.notifyToastDanger(
            context: context, message: errors.values.toList()[0][0]);
      } else if (data.statusCode == 200) {
        // state.notifyToastSuccess(
        //     context: context, message: 'Your registration was successful');
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new RoomList(
                      house: widget.house,
                    )));
      } else {
        state.notifyToastDanger(
            context: context, message: "Error occured while creating account");
//        Navigator.push(context, MaterialPageRoute(builder: (context)=> new LoginPage()));
      }
      setState(() {
        status = false;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        status = false;
      });
    });
  }
}
