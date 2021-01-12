import 'package:shared/common/styles/themes.dart';
import 'package:shared/common/utils/name_routes.dart';
import 'app_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fundamental_flutter/splash/splashscreen.dart';
import 'package:main/main.dart';
import 'package:authentification/authentification.dart';

class AppModule extends MainModule {

  @override
  List<Bind> get binds => [];

  @override
  Widget get bootstrap => EasyLocalization(
    path: 'assets/languages',
    supportedLocales: [Locale('en', 'US'), Locale('id', 'ID')],
    child: SimpleApps(),
  );

  @override
  List<ModularRouter> get routers => [
    ModularRouter(
      Modular.get<NamedRoutes>().splashPage,
      child: (context, args) => SplashScreen(),
    ),
    ModularRouter(
      Modular.get<NamedRoutes>().mainPage,
      module: FeatureMainModule(),
    ),
    ModularRouter(
      Modular.get<NamedRoutes>().loginPage,
      module: FeaturesAuthModule(),
    ),
  ];
}

class SimpleApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: Config.isDebug,
      theme: lightTheme,
      initialRoute: Modular.get<NamedRoutes>().splashPage,
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
