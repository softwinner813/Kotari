import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:foster_logger/pages/house.dart';
import 'package:foster_logger/pages/scanner_icon_icons.dart';
import 'package:foster_logger/store/data_notifier.dart';
import 'package:provider/provider.dart';
import 'package:foster_logger/store/index.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:foster_logger/store/constants.dart';

class HouseList extends StatefulWidget {
  HouseList({Key key, this.data}) : super(key: key);
  final data;

  @override
  _HouseList createState() => new _HouseList();
}

class _HouseList extends State<HouseList> {
  AppState state;
  String error = '';
  bool status = false;
  Color color = Colors.green.withOpacity(0.6);

  List items = [];
  String nextPage = '';
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int total = 0;
  int current = 0;

  // Sort DropDown
  List<String> _matchDropList = ['Best Match', 'High Price', 'Low Price'];
  String _matchDropDown;
  String _sort = 'none';

  // Island Name map
  // List<String> _matchIslandDropList = [
  //   'none',
  //   'Dhiffushi',
  //   'Himmafushi',
  //   'Hulhumalé',
  //   'Huraa',
  //   'Malé',
  //   'Thulusdhoo',
  //   'Villingili',
  //   'Gulhi',
  //   'Guraidhoo',
  //   'Maafushi',
  //   'Gaafaru',
  //   'Kaashidhoo'
  // ];

  List<String> _matchIslandDropList = islands;
  String _islandDropDown;

  // Room offer
  List _roomOffer;
  String _roomOfferResult;

  // Facility Offer
  List _facility;
  String _facilityResult;

  // Budget
  SfRangeValues _budget = SfRangeValues(0.0, 5000.0);

  // Searchbar
  bool _visibleSearch = false;
  TextEditingController _searchController;

  void initState() {
    super.initState();
    state = Provider.of<AppState>(context, listen: false);
    print(widget.data['next_page_url']);
    print(widget.data['first_page_url']);

    _searchController = TextEditingController();
    setState(() {
      _matchDropDown = _matchDropList[0];
      items = widget.data['data'];
      total = widget.data['total'];
      current = widget.data['current_page'];
      nextPage = widget.data['next_page_url'];

      // Filter Initialize
      _roomOffer = [];
      _roomOfferResult = '';
      _facility = [];
      _facilityResult = '';
      _islandDropDown = _matchIslandDropList[0];
    });
    // getItems(state.endpoint + "getHouseList/");
  }

  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = AppBar().preferredSize.height;
    Color mainColor = Theme.of(context).primaryColor;
    Color mainAccentColor = Theme.of(context).accentColor;
    Color backColor = Colors.grey[200];
    TextStyle headerText = Theme.of(context).textTheme.headline4;

    return WillPopScope(
      onWillPop: () {},
      child: new Scaffold(
        // ------------Right Slider --------------
        endDrawer: new Drawer(
          child: Container(
            padding: EdgeInsets.all(20),
            child: new ListView(
              children: <Widget>[
                // ------- Header and Sort -----------------
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // --------- Drawer Name (Filter) ---------
                      Container(
                        child: Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'Oepn-Sans',
                          ),
                        ),
                      ),

                      // --------- Sort Dropdownbox -----------
                      new Container(
                        padding: EdgeInsets.only(left: 10, right: 5),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: mainColor,
                            width: 2,
                          ),
                        ),
                        child: new DropdownButton<String>(
                          underline: Container(),
                          value: _matchDropDown,
                          focusColor: Colors.black,
                          // dropdownColor: mainColor,
                          dropdownColor: Colors.white,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          style: TextStyle(color: Colors.white),
                          items: _matchDropList.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(
                                    fontFamily: 'Oepn-Sans',
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            // print(newValue);
                            setState(() {
                              _matchDropDown = newValue;
                            });

                            // var filter =
                            //     Provider.of<DataNotifier>(context, listen: false)
                            //         .roomFilter;
                            String sort = '';
                            switch (newValue) {
                              case 'Best Match':
                                sort = 'best';
                                break;
                              case 'High Price':
                                sort = 'highPrice';
                                break;
                              case 'Low Price':
                                sort = 'lowPrice';
                                break;
                            }
                            // Provider.of<DataNotifier>(context, listen: false)
                            // .updateRoomFilter(filter);
                            setState(() {
                              _sort = sort;
                            });

                            // getItems(state.endpoint + "roomFilter");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // ------- Island ---------
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    "Island",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Oepn-Sans',
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 15),
                  child: new DropdownButton<String>(
                    value: _islandDropDown,
                    underline: Container(),
                    style: TextStyle(color: Colors.white),
                    items: _matchIslandDropList.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Container(
                          // width: MediaQuery.of(context).size.width - 80,
                          child: new Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Oepn-Sans',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        _islandDropDown = newValue;
                      });
                    },
                  ),
                ),
                // ------- Budget ---------
                Padding(padding: EdgeInsets.only(top: 30)),
                Text(
                  "Budget",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Oepn-Sans',
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 400,
                  child: SfRangeSlider(
                    min: 0.0,
                    max: 5000.0,
                    activeColor: mainColor,
                    values: _budget,
                    interval: 1000.0,
                    // showTicks: true,
                    // showLabels: true,
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
                Padding(padding: EdgeInsets.only(top: 20)),
                MultiSelectFormField(
                  autovalidate: false,
                  chipBackGroundColor: mainColor,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blueAccent,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Room offers:",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Oepn-Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dataSource: services,
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
                  // chipBackGroundColor: Color.fromRGBO(0, 153, 0, 1.0),
                  chipBackGroundColor: mainColor,
                  chipLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oepn-Sans',
                  ),
                  dialogTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oepn-Sans',
                  ),
                  checkBoxActiveColor: mainColor,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Facilities:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dataSource: services,
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
                          : Text(
                              "Search",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Oepn-Sans',
                                color: Colors.white,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                      onPressed: () async {
                        await filter();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: backColor,
        appBar: new AppBar(
          leading: new Container(),
          title: new Text(
            'Kotari',
            style: TextStyle(
                fontFamily: 'OpenSans', fontSize: 40, color: mainColor),
          ),
          centerTitle: true,
          backgroundColor: backColor,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 0.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _visibleSearch = !_visibleSearch;
                  });
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                  color: mainColor,
                ),
              ),
            ),
            Builder(
              builder: (context) => Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    ScannerIcon.sliders,
                    size: 26.0,
                    color: mainColor,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
            ),
          ],
        ),
        body: new SafeArea(
          child: new Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --------- Search Bar ---------
                if (_visibleSearch)
                  Container(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 15, right: 13),
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: new TextField(
                              autofocus: true,
                              // expands: true,
                              controller: _searchController,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Oepn-Sans',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  String term = _searchController.text;
                                  print('---------------------');
                                  print(term);

                                  search(term);

                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }),
                          ),

                          // IconButton(icon: Icon(Icons.search), onPressed: null),
                        ],
                      ),
                    ),
                  ),

                ////******************* List of House *////////////////
                (status)
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      )
                    : new Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height:
                          // MediaQuery.of(context).size.height - 60 - 2 * appHeight,
                          decoration: BoxDecoration(
                            color: backColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                          ),
                          child: new SmartRefresher(
                            // header: WaterDropHeader(),
                            controller: _refreshController,
                            enablePullUp: true,
                            enablePullDown: true,
                            child: (items.length == 0)
                                ? Center(
                                    child: Text(
                                      "No place registered yet.",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : new SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (var item in items)
                                          new Container(
                                            child: new House(
                                              house: item,
                                            ),

                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 15,
                                            ),
                                            // margin: EdgeInsets.only(bottom: 20),
                                          ),
                                      ],
                                    ),
                                  ),
                            footer: new CustomFooter(
                              builder: (BuildContext context, LoadStatus mode) {
                                Widget body;
                                if (mode == LoadStatus.idle &&
                                    mode != LoadStatus.noMore) {
                                  body = Text("");
                                } else if (mode == LoadStatus.loading) {
                                  body = CupertinoActivityIndicator();
                                } else if (mode == LoadStatus.failed) {
                                  body = Text("");
                                } else if (mode == LoadStatus.canLoading) {
                                  body = Text("");
                                }
                                if (nextPage == null) {
                                  body = Text("");
                                }
                                return Container(
                                  height: 55.0,
                                  child: Center(child: body),
                                );
                              },
                            ),
                            onRefresh: () async {
                              setState(() {
                                items = [];
                              });
                              await getItems(state.endpoint + "getHouseList");
                            },
                            onLoading: () async {
                              if (nextPage == null) {
                                _refreshController.loadNoData();
                              } else {
                                await getItems(nextPage);
                              }
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///*************** Name or Island Search ***************/
  void search(String value) async {
    // await getItems(url);
    setState(() {
      items = [];
      _searchController.text = '';
    });

    Map data = {
      'value': value.toString(),
    };

    await getItems(state.endpoint + 'nameSearch', data);
  }

  ///************** Filter *******************/
  Future<void> filter() async {
    var sendData = {
      'island': _islandDropDown.toString(),
    };
    for (var room in _roomOffer) {
      sendData['house_' + room] = room;
    }

    for (var facility in _facility) {
      sendData['facility_' + facility] = facility;
    }
    sendData['minBudget'] = _budget.start.toString();
    sendData['maxBudget'] = _budget.end.toString();

    sendData['sort'] = _sort;

    // String sort = Provider.of<DataNotifier>(context, listen: false).sort;
    // sendData['sort'] = sort;

    //Save HouseFilter Data
    // Provider.of<DataNotifier>(context, listen: false)
    //     .updateHouseFilter(sendData);

    setState(() {
      status = true;
      items = [];
    });

    await getItems(state.endpoint + 'houseFilter', sendData);
  }

  ///*************** Get Data from backend */
  Future<void> getItems(url, [Map data]) async {
    // var filter = Provider.of<DataNotifier>(context, listen: false).houseFilter;
    // if (items.length == 0) {
    setState(() {
      status = true;
    });
    // }

    state.postURL(url, data).then((data) {
      var body = jsonDecode(data.body);
      print(body);
      if (data.statusCode == 422) {
        Map<String, dynamic> response = jsonDecode(data.body);
        Map<String, dynamic> errors = response['errors'];
        state.notifyToastDanger(
            context: context, message: errors.values.toList()[0][0]);
      } else if (data.statusCode == 200) {
        var data = body['houses'];
        setState(() {
          items.addAll(data['data']);
          total = data['total'];
          current = data['current_page'];
          nextPage = data['next_page_url'];
          status = false;
        });
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
      } else {
        state.notifyToastDanger(
            context: context, message: "Error occured while getting data");
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
