import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/common/utils/name_routes.dart';
import 'common/styles/color_palettes.dart';
import 'package:shared/common/utils/locale_keys.dart';

class SharedModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((_) => ColorPalettes()),
    // Bind((_) => ImageAssets()),
    Bind((_) => NamedRoutes()),
    Bind((_) => LocaleKeys()),
  ];

  @override
  List<ModularRouter> get routers => [];
}