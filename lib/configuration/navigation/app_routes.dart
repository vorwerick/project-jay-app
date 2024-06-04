enum AppRoutes {
  login('login'),
  home('home'),
  eventHistory('alarm_event-history'),
  eventDetail('alarm_event-detail'),
  pdf('pdf'),
  settings('settings'),
  deviceRegistration('deviceRegistration');

  final String name;

  String get path => '/$name';

  const AppRoutes(this.name);
}
