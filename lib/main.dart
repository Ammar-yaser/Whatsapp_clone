import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/validators/FormsValidation.dart';

// Pages
import 'ui/screens/chat/Chat.dart';
import 'ui/screens/user_info/UserInfo.dart';
import 'blocs/providers/registration/registration_state.dart';
import 'services/auth_services.dart';
import 'ui/screens/home/Home.dart';
import 'ui/screens/registration/Registration.dart';
import 'ui/screens/registration/sms_verification/smsVerification.dart';

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
        accentColor: Color.fromRGBO(220, 248, 198, 1),
        textTheme: TextTheme().copyWith(
          headline6: TextStyle(fontSize: 18),
          caption: TextStyle(fontSize: 14),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Registration.id,//Home.id,
      routes: {
        Registration.id: (BuildContext context) => Registration(),
        SmsVerification.id: (BuildContext context) => SmsVerification(),
        UserInfoData.id: (BuildContext context) => UserInfoData(),
        Home.id: (BuildContext context) => Home(),
      },
    );
  }
}

// TODO: splash screen
