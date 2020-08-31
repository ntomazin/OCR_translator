import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "uzorak";
  String _translation = "sample";
  String _language = "english";


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
        buttonColor: Colors.blueGrey,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('OCR Translator'),
        ),
        body: Center(
            child: new ListView(
          children: <Widget>[
            new Text(
                _textValue,
                style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                  height: 3.0,
              ),
            ),
            ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton(
                onPressed: _read,
                child: new Text('Start Scanning'),
              ),
            ),
            new Text(
              _translation,
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                height: 3.0,
              ),
            ),
            ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton(
                onPressed: _read,
                child: new Text('Translate from: ' + _language),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    String words = "";
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );
      for (var i=0; i<texts.length; i++) {
        words += texts[i].value + " ";
      }
      setState(() {
        _language = texts[0].language;
        _textValue = words;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
}
