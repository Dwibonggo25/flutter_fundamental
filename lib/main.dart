import 'package:flutter/material.dart';
import 'learning_path.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Detector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numTaps = 0;

  final double boxSize = 150.0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Detector'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            numTaps++;
          },
          child: Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(color: Colors.red),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(16.0),
        child: Column (
          children: [
            RaisedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LearningPathPage();
              }));
            }),
            defaultTargetPlatform == TargetPlatform.iOS
                ? Text('iOS')
                : Text('Android'),
            Text(
              'Taps: $numTaps - Double Taps: 0 - Long Press: 0',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        )
      ),
    );
  }
}