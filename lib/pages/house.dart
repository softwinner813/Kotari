import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foster_logger/pages/roomList.dart';
import 'package:foster_logger/pages/room_detail.dart';
// import 'package:foster_logger/pages/house_detail.dart';
import 'package:provider/provider.dart';
import 'package:foster_logger/store/index.dart';
import 'dart:convert';

import 'package:getwidget/getwidget.dart';

class House extends StatefulWidget {
  House({Key key, this.house}) : super(key: key);
  final Map house;
  @override
  _House createState() => new _House();
}

class _House extends State<House> {
  AppState state;

  Color color = Colors.green.withOpacity(0.6);
  Map house;
  List images = [];
  String url = '';
  void initState() {
    super.initState();
    state = Provider.of<AppState>(context, listen: false);

    setState(() {
      house = widget.house;
      images = house['images'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = AppBar().preferredSize.height;
    Color mainColor = Theme.of(context).primaryColor;
    Color mainAccentColor = Theme.of(context).accentColor;
    TextStyle headerText = Theme.of(context).textTheme.headline4;
    return new Container(
      child: new GestureDetector(
        onTap: () {
          print(widget.house['rooms'].length);
          var room = widget.house['rooms'];
          int countRoom = room.length;

          if (countRoom == 0) {
            // Room is no exist
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new RoomList(house: widget.house)));
          } else if (countRoom == 1) {
            // Room is only 1
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new RoomDetail(
                          room: room[0],
                        )));
          } else {
            // more than 2
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new RoomList(house: widget.house)));
          }
        },
        child: new Container(
          // margin: EdgeInsets.only(top: 10),
          // padding: EdgeInsets.only(top: 6, bottom: 6, left: 6, right: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500].withOpacity(0.7),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(2, 1), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            height: 100,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: (images.length != 0)
                      ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    state.url + images[0]['path'],
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )
                      : GFShimmer(
                          mainColor: GFColors.DARK.withOpacity(0.22),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                house['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    Container(
                                      // padding: EdgeInsets.only(left: 3),
                                      child: Text(
                                        house['island'],
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            // fontsiz
                                            color: Colors.grey[700],
                                            fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'MVR',
                                      style: TextStyle(color: mainColor),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        (house['price'] == null)
                                            ? '0'
                                            : house['price'].toString(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
}
