abstract interface class DeviceInformation {
  String get manufacturer;

  String get device;

  String get version;

  int get buildNumber;

  int get sdk;

  String get firebaseToken;
}
