import 'package:flutter/material.dart';

class ConfirmAction extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!
  Color color = Color.fromARGB(220, 117, 218, 255);
  String title;
  String content;
  Function yesOnPressed;
  Function noOnPressed;

  ConfirmAction({
    String title,
    String content,
    Function yesOnPressed,
    Function noOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(title),
      content: new Text(content),
      backgroundColor: color,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Yes'),
          textColor: Colors.greenAccent,
          onPressed: () {
            yesOnPressed();
          },
        ),
        new FlatButton(
          child: Text('No'),
          textColor: Colors.redAccent,
          onPressed: () {
            noOnPressed();
          },
        ),
      ],
    );
  }
}
