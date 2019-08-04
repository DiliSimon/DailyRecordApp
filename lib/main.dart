// Flutter code sample for material.Radio.1

// Here is an example of Radio widgets wrapped in ListTiles, which is similar
// to what you could get with the RadioListTile widget.
//
// The currently selected character is passed into `groupValue`, which is
// maintained by the example's `State`. In this case, the first `Radio`
// will start off selected because `_character` is initialized to
// `SingingCharacter.lafayette`.
//
// If the second radio button is pressed, the example's state is updated
// with `setState`, updating `_character` to `SingingCharacter.jefferson`.
// This causes the buttons to rebuild with the updated `groupValue`, and
// therefore the selection of the second button.
//
// Requires one of its ancestors to be a [Material] widget.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'util.dart';
import 'first_page.dart';


void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: FirstPage(),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DailyRecord')),
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final myController = TextEditingController();
  int _gv = -1;

  Widget build(BuildContext context) {
    return
      Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          child: Center(
            child: Text('How are you feeling?', style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0).copyWith(color: Colors.blue, fontWeight: FontWeight.bold),),
          )),
          ListTile(
            title: const Text('Happy'),
            leading: Radio(
              value: 1,
              groupValue: _gv,
              onChanged: (val) {
                setState(() {
                  _gv = val;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Sad'),
            leading: Radio(
              value: 2,
              groupValue: _gv,
              onChanged: (val) {
                setState(() {
                  _gv = val;
                });
              },
            ),
          ),
          Container(
            width: 300,
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                hintText: 'Type notes here'
              )
            ),
          ),
          RaisedButton(
            child: const Text('submit'),

            onPressed: () async{
              print('pressed');
              var t = myController.text;
              var butt = _gv;
              print(butt);
              var p = await fetchPost(t, butt);
              //var status = p.body;
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the that user has entered by using the
                    // TextEditingController.
                    content: Text(p.body),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}