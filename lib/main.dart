import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:retrofit_flutter/home_page.dart';

final logger = Logger();

// void main(List<String> args) {
//   final dio = Dio(); // Provide a dio instance
//   dio.options.headers['Demo-Header'] =
//       'demo header'; // config your dio headers globally
//   final client = RestClient(dio);

//   client.getTasks().then((it) => logger.f(it[0].name));åß
// }
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
