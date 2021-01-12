import 'package:flutter/material.dart';
import 'package:shared/common/utils/name_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login/presentation/ui/login_screen.dart';

class FeaturesAuthModule extends ChildModule {

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(
      Modular.get<NamedRoutes>().loginPage,
      child: (context, arg) => LoginPage(),
    ),
  ];
}


