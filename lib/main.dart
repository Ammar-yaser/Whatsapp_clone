import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/validators/FormsValidation.dart';
import 'package:whatsapp_clone/ui/screens/user_info/UserInfo.dart';

// Pages
import 'blocs/providers/registration/registration_state.dart';
import 'services/auth_services.dart';
import 'ui/screens/home/Home.dart';
import 'ui/screens/registration/PhoneVerification.dart';
import 'ui/screens/registration/Registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FormsValidation>(
          create: (_) => FormsValidation(),
        ),
        ChangeNotifierProvider<RegistState>(
          create: (_) => RegistState(),
        ),
        Provider<AuthServices>(
          create: (_) => AuthServices(),
        ),
      ],
      child: StartPoint(),
    );
  }
}

class StartPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(9, 94, 84, 1),
        textTheme: TextTheme().copyWith(
          headline6: TextStyle(fontSize: 18),
          caption: TextStyle(fontSize: 14),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Registration.id,
      routes: {
        Registration.id: (BuildContext context) => Registration(),
        PhoneVerification.id: (BuildContext context) => PhoneVerification(),
        UserInfo.id: (BuildContext context) => UserInfo(),
        Home.id: (BuildContext context) => Home(),
      },
    );
  }
}

// TODO: splash screen
