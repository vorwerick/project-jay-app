enum AppRoutes {
  login('login'),
  home('home'),
  eventHistory('event-history'),
  eventDetail('event-detail');

  final String name;

  String get path => '/$name';

  const AppRoutes(this.name);
}
