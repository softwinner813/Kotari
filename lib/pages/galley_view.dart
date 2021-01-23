import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:foster_logger/store/index.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:getwidget/getwidget.dart';

class GalleryView extends StatefulWidget {
  GalleryView({Key key, this.images, this.initIndex}) : super(key: key);
  final List images;
  final int initIndex;

  @override
  _GalleryView createState() => new _GalleryView();
}

class _GalleryView extends State<GalleryView> {
  AppState state;
  String error = '';
  bool status = false;
  Color color = Colors.green.withOpacity(0.6);
  List images = [];
  int initIndex = 0;
  // String state.url = 'http://10.10.10.179/';

  void initState() {
    super.initState();
    state = Provider.of<AppState>(context, listen: false);

    setState(() {
      images = widget.images;
      initIndex = widget.initIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Gallery',
          style: new TextStyle(fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: new SafeArea(
        child: new SingleChildScrollView(
          child: new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // margin: EdgeInsets.only(top: 20),
              // padding: EdgeInsets.only(bottom: 85),
              color: Colors.black,
              child: Center(
                child: GFCarousel(
                  initialPage: initIndex,
                  height: MediaQuery.of(context).size.height,
                  autoPlay: true,
                  pagination: true,
                  viewportFraction: 1.0,
                  activeIndicator: GFColors.SUCCESS,
                  passiveIndicator: GFColors.WHITE,
                  aspectRatio: 2,
                  items: images
                      .map((image) => Container(
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height,
                            child: Image.network(
                              state.url + image['path'],
                              fit: BoxFit.contain,
                            ),
                          ))
                      .toList(),
                ),
              )),
        ),
      ),
    );
  }
}
