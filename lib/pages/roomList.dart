import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:foster_logger/pages/house.dart';
import 'package:foster_logger/pages/room.dart';
import 'package:foster_logger/pages/scanner_icon_icons.dart';
import 'package:foster_logger/store/data_notifier.dart';
import 'package:provider/provider.dart';
import 'package:foster_logger/store/index.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoomList extends StatefulWidget {
  RoomList({Key key, this.house}) : super(key: key);
  final house;

  @override
  _RoomList createState() => new _RoomList();
}

class _RoomList extends State<RoomList> {
  AppState state;
  String error = '';
  bool status = false;
  Color color = Colors.green.withOpacity(0.6);

  List items = [];
  String nextPage = '';
  String firstPage = '';
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<String> _matchDropList = ['Best Match', 'High Price', 'Low Price'];
  String _matchDropDown;

  int total = 0;
  int current = 0;

  void initState() {
    super.initState();
    state = Provider.of<AppState>(context, listen: false);

    setState(() {
      _matchDropDown = _matchDropList[0];
    });

    getItems(state.endpoint + "roomFilter");
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = AppBar().preferredSize.height;

    Color mainColor = Theme.of(context).primaryColor;
    Color backColor = Colors.grey[200];
    return new Scaffold(
      backgroundColor: backColor,
      appBar: new AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: mainColor),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0,
        title: new Text(
          widget.house['name'],
          style: new TextStyle(
              fontFamily: 'OpenSans', fontSize: 30, color: mainColor),
        ),
        centerTitle: true,
        backgroundColor: backColor,
      ),
      body: new SafeArea(
        child: new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        padding: EdgeInsets.only(top: 5),
                        // height:
                        // MediaQuery.of(context).size.height - 60 - 2 * appHeight,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                        ),
                        child: (status)
                            ? // If Loading Data

                            Center(
                                child: CircularProgressIndicator(),
                              )
                            : // If have got the data successfully
                            new SmartRefresher(
                                // header: WaterDropHeader(),
                                controller: _refreshController,
                                enablePullUp: true,
                                enablePullDown: false,
                                child: new SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      for (var item in items)
                                        new Container(
                                          child: new Room(
                                            room: item,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 20,
                                          ),
                                          // margin: EdgeInsets.only(bottom: 20),
                                        ),
                                    ],
                                  ),
                                ),
                                footer: new CustomFooter(
                                  builder:
                                      (BuildContext context, LoadStatus mode) {
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
                                onRefresh: () {
                                  setState(() {
                                    items = [];
                                  });
                                  getItems(firstPage);
                                },
                                onLoading: () {
                                  if (nextPage == null) {
                                    _refreshController.loadNoData();
                                  } else {
                                    getItems(nextPage);
                                  }
                                },
                              ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  ///*************** Get Data from backend */
  void getItems(url) async {
    var filter = Provider.of<DataNotifier>(context, listen: false).roomFilter;
    filter['house_id'] = widget.house['id'].toString();

    print(_matchDropDown);
    switch (_matchDropDown) {
      case 'Best Match':
        filter['sort'] = 'best';
        break;
      case 'High Price':
        filter['sort'] = 'highPrice';
        break;
      case 'Low Price':
        filter['sort'] = 'lowPrice';
        break;
    }
    print(filter);
    if (items.length == 0) {
      setState(() {
        status = true;
      });
    }

    state.postURL(url, filter).then((data) {
      var body = jsonDecode(data.body);
      if (data.statusCode == 422) {
        Map<String, dynamic> response = jsonDecode(data.body);
        Map<String, dynamic> errors = response['errors'];
        state.notifyToastDanger(
            context: context, message: errors.values.toList()[0][0]);
      } else if (data.statusCode == 200) {
        var data = body['rooms'];
        setState(() {
          items.addAll(data['data']);
          total = body['count'];
          current = data['current_page'];
          nextPage = data['next_page_url'];
          firstPage = data['first_page_url'];
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
