import 'package:core/bloc/simple_apps.dart';
import 'package:core/core.dart';
import 'package:core/network/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fundamental_flutter/launcher/app_config.dart';
import 'package:flutter/services.dart';
import 'package:fundamental_flutter/launcher/simple_app.dart';
import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'simple_app.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  Config.appFlavor = Flavor.DEVELOPMENT;
  WidgetsFlutterBinding.ensureInitialized();

  /// Init core and shared module
  final preferences = await SharedPreferences.getInstance();
  Modular.init(
      CoreModule(baseUrl: ApiConstant.baseUrlDebug, preferences: preferences));
  Modular.init(SharedModule());

  /// Change device orientation and force to portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(ModularApp(module: AppModule())));
}