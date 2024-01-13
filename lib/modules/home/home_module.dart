import 'package:flutter_modular/flutter_modular.dart';
import '../home/presentation/home_page.dart'; // Ensure this path is correct

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => HomePage());
    // Add more child routes specific to the HomeModule here
    // Example: r.child('/detail', child: (context) => DetailPage()),
  }
}
