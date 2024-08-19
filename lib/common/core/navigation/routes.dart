class RouteObject {
  final String name;
  final String path;

  RouteObject({required this.name, required this.path});
}

class Routes {
  static RouteObject login = RouteObject(name: "Login", path: '/');
  static RouteObject userRegister = RouteObject(name: "UserRegister", path: '/userRegister');
  static RouteObject userDetails = RouteObject(name: "UserDetails", path: '/userDetails');
}
