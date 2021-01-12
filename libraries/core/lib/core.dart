import 'package:core/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreModule extends ChildModule {
  final String baseUrl;
  final SharedPreferences preferences;

  CoreModule({@required this.baseUrl, @required this.preferences});

  @override
  List<Bind> get binds => [
    Bind((_) => Modular.get<DioClient>().dio),
    Bind((_) => DioClient(apiBaseUrl: baseUrl)),
    Bind((_) => preferences),
  ];

  @override
  List<ModularRouter> get routers => [];
}