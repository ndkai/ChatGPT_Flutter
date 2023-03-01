import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> onWillPop(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Thoát?'),
      content: new Text('Bạn thật sự muốn thoát chứ?'),
      actions: <Widget>[
        new MaterialButton(
          onPressed: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          child: new Text('Yes'),
        ),
        new MaterialButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('No'),
        ),
      ],
    ),
  )) ??
      false;
}