import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:foster_logger/store/index.dart';
import 'package:flutter/services.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:foster_logger/pages/scanner_icon_icons.dart';

class RoomDetail extends StatefulWidget {
  RoomDetail({Key key, this.room}) : super(key: key);
  final Map room;

  @override
  _RoomDetail createState() => new _RoomDetail();
}

class _RoomDetail extends State<RoomDetail> {
  AppState state;
  String error = '';
  bool status = false;
  Color color = Colors.green.withOpacity(0.6);
  List items = [];
  String nextPage = '';
  Map room;
  List images = [];
  // String endpoint = 'http://10.10.10.179/';

  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    state = Provider.of<AppState>(context, listen: false);
    setState(() {
      room = widget.room;
      images = room['images'];
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color badgeColor = Theme.of(context).primaryColor;
    // Color badgeColor = Colors.blue;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return new Scaffold(
      backgroundColor: Colors.white,
      // appBar: new AppBar(
      //   leading: new IconButton(
      //     icon: new Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     color: Colors.white,
      //   ),
      //   title: new Text(
      //     room['name'],
      //     style: new TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   // backgroundColor: Theme.of(context).primaryColor,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: new SafeArea(
        child: new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              new Stack(
                children: [
                  new Container(
                      height: MediaQuery.of(context).size.width * 0.8,
                      width: MediaQuery.of(context).size.width,
                      //
                      margin: EdgeInsets.only(bottom: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                        child: Carousel(
                          images: [
                            for (var item in images)
                              NetworkImage(
                                state.url + item['path'],
                              ),
                          ],
                        ),
                      )),
                  Positioned(
                    left: 20,
                    top: 50,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      // height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: badgeColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          if (room['visible_cut'] == 1)
                            Text(
                              'MVR ' + room['pre_price'].toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.grey[850],
                                  fontFamily: "OpenSans",
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Text(
                            'MVR ' + room['cur_price'].toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                              fontFamily: "OpenSans",

                              color: badgeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (room['visible_cut'] == 1)
                    Positioned(
                      right: 10,
                      top: 30,
                      child: Container(
                        height: 80,
                        width: 80,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: AssetImage('assets/images/price_off.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                room['cut_rate'].toString() + '%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OpenSans",
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Off',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OpenSans",
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              //------ Main Part ------------------------
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: ListView(
                    children: <Widget>[
                      // ---------- Name and Island -----------

                      Container(
                        child: Row(
                          children: <Widget>[
                            //--------- Room Name ------------
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    // Icon(
                                    //   Icons.king_bed,
                                    //   color: Colors.grey[700],
                                    // ),
                                    Container(
                                      child: Text(
                                        room['name'],
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: "OpenSans",
                                          // fontWeight: FontWeight.bold,
                                          // fontsiz
                                          color: Colors.black,
                                          // color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //--------- Island Name -------------
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: badgeColor,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        room['island'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "OpenSans",
                                          // fontWeight: FontWeight.bold,
                                          // fontsiz
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ------ Service Row ------------------
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 70,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            if (room['internet'] == 1 ||
                                room['f_internet'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.wifi,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Wi-Fi",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['restaurant'] == 1 ||
                                room['f_restaurant'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.restaurant,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Restaurant",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['bar'] == 1 || room['f_bar'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.local_bar,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Bar",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['room_service'] == 1 ||
                                room['f_room_service'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.room_service,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Room Service",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['breakfast'] == 1 ||
                                room['f_breakfast'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.free_breakfast,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Breakfast",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['front_desk'] == 1 ||
                                room['f_front_desk'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.people,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Front Desk",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['kid'] == 1 || room['f_kid'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.child_care,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Kid Friendly",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['pool'] == 1 || room['f_pool'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.pool,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Pool",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['park'] == 1 || room['f_park'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.local_parking,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Parking",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['fitness'] == 1 || room['f_fitness'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.fitness_center,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Fitness Center",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['air'] == 1 || room['f_air'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.ac_unit,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Air Conditioning",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['beach'] == 1 || room['f_beach'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.beach_access,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Beach Access",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['hot'] == 1 || room['f_hot'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.hot_tub,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Hot tub",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['spa'] == 1 || room['f_spa'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.spa,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Spa",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['laundry'] == 1 || room['f_laundry'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.local_laundry_service,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Laundry",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['tv'] == 1 || room['f_tv'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.live_tv,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "TV",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            if (room['smoke'] == 1 || room['f_smoke'] == 1)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      ScannerIcon.smoke_free,
                                      color: badgeColor,
                                    ),
                                    Text(
                                      "Smoke Free",
                                      style: TextStyle(
                                          color: badgeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      // ------ Detail ----------
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Detail',
                                    style: TextStyle(
                                      fontSize: 20,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: "OpenSans",
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: MediaQuery.of(context).size.height,
                                      child: (room['desc'] == null)
                                          ? Text('')
                                          : Text(
                                              room['desc'],
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontFamily: 'OpenSans',
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 16),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      "Contact Us",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: "OpenSans"),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10, left: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.mail,
                                          color: badgeColor,
                                          size: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "Email: ",
                                            style: TextStyle(
                                              color: badgeColor,
                                              fontSize: 17,
                                              fontFamily: 'Oepn-Sans',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            room['email'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Oepn-Sans',
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10, left: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              ScannerIcon.address_book,
                                              size: 20,
                                              color: badgeColor,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                "Address: ",
                                                style: TextStyle(
                                                  color: badgeColor,
                                                  fontSize: 17,
                                                  fontFamily: 'Oepn-Sans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              room['address'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'Oepn-Sans',
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10, left: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          ScannerIcon.perm_phone_msg,
                                          color: badgeColor,
                                          size: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "Phone Number: ",
                                            style: TextStyle(
                                              color: badgeColor,
                                              fontSize: 17,
                                              fontFamily: 'Oepn-Sans',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            room['phone'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Oepn-Sans',
                                              // fontWeight: FontWeight.bold,
                                            ),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
