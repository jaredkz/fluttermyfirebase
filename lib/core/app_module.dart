// ignore_for_file: avoid-dynamic

import 'package:flutter_modular/flutter_modular.dart';
import '../modules/auth/auth_module.dart';
import '../modules/home/home_module.dart';
import '../modules/auth/domain/auth_controller.dart'; // Import AuthController.

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(AuthController.new);
    // Add other global bindings here if necessary.
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
    r.module('/home', module: HomeModule());
    // Define other routes or modules as necessary.
  }
}
