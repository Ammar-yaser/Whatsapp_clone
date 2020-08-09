import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pages
import 'blocs/providers/registration/registration_state.dart';
import 'services/auth_services.dart';
import 'ui/screens/home/Home.dart';
import 'ui/screens/registration/Signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (_) => AuthServices(),
        ),
        ChangeNotifierProvider<RegistState>(
          create: (_) => RegistState(),
        )
      ],
      child: StartPoint(),
    );
  }
}

class StartPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(9, 94, 84, 1),
        textTheme: TextTheme().copyWith(
          headline6: TextStyle(fontSize: 18),
          caption: TextStyle(fontSize: 14),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Signup(),
    );
  }
}

// TODO: splash screen
