enum AppRoutes {
  login('login'),
  home('home'),
  homeInactive('home-inactive'),
  eventHistory('event-history'),
  eventDetail('event-detail'),
  pdf('pdf');

  final String name;

  String get path => '/$name';

  const AppRoutes(this.name);
}
