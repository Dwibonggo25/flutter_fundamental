enum Flavor {
  DEVELOPMENT,
  RELEASE,
  UAT,
}

class Config {
  static Flavor appFlavor;

  static bool get isDebug {
    switch (appFlavor) {
      case Flavor.RELEASE:
        return false;
      case Flavor.DEVELOPMENT:
        return true;
      case Flavor.UAT:
        return true;
      default:
        return true;
    }
  }
}
