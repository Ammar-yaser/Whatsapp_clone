import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/providers/registration/registration_state.dart';
import '../../services/shared_pref_services.dart';
import 'dart:async';

import 'home/Home.dart';
import 'registration/Registration.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    SharedPrefServices prefServices =
        Provider.of<SharedPrefServices>(context, listen: false);
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    bool isRemebered = await prefServices.isRemembered();
    String page;
    if (isRemebered == null || isRemebered == false) {
      page = Registration.id;
    } else {
      registState.setUserId = await prefServices.getId();
      page = Home.id;
    }
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        page,
        (Route route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash_icon.png',
          width: 130,
          height: 130,
        ),
      ),
    );
  }
}
