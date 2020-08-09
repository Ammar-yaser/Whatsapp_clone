import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../../blocs/providers/registration/registration_state.dart';
import '../../../services/auth_services.dart';
import '../../../blocs/validators/RegExp.dart';

import '../../widgets/PhoneNumber.dart';
import 'PhoneVerification.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Column(
            children: [
              Text('Enter your phone number', style: theme.textTheme.headline6),
              SizedBox(height: 15),
              Text(
                'We will send OTP code for verification your phone number',
                style: theme.textTheme.caption,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  String phoneValidate(String fieldVal) {
    if (fieldVal.isEmpty) {
      return 'You should write your number';
    } else if (!phoneRegExp.hasMatch(fieldVal)) {
      return 'Invalid Phone number';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    AuthServices authServices =
        Provider.of<AuthServices>(context, listen: false);
    print('rebuild');
    return Form(
      key: formKey,
      child: Column(
        children: [
          PhoneNumber(
            onSaved: (String phone) => registState.setPhone(phone),
            controller: _phoneController,
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text('Next'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
              // ToDo: show this error message to user
              String isValid; //phoneValidate(_phoneController.text);
              print(isValid);
              if (isValid == null) {
                formKey.currentState.save();
                print(registState.phone);
                authServices.verifyPhone(
                  phone: '+201271852177',
                  pinCodePage: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PhoneVerification()),
                    );
                  },
                  autoCode: () {
                    registState.autoCode = '000000';
                  }
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
