import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/common/utils/name_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea (
        child: Stack (
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder <String> (
                future: _getVersion(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  var verInfo = "frrrrrr";
                  return Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Text(verInfo),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> _getVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  void _navigationPage() {
    Modular.to.pushReplacementNamed(Modular.get<NamedRoutes>().mainPage);
  }

  _startSplashScreen() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, _navigationPage);
  }
}
