import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/validators/FormsValidation.dart';
import '../../../blocs/providers/registration/registration_state.dart';
import '../../../services/auth_services.dart';
import '../../../blocs/validators/RegExp.dart';

import '../home/Home.dart';
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

  @override
  Widget build(BuildContext context) {
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    FormsValidation validation =
        Provider.of<FormsValidation>(context, listen: false);
    AuthServices authServices =
        Provider.of<AuthServices>(context, listen: false);

    return Form(
      key: formKey,
      child: Column(
        children: [
          PhoneNumber(
            controller: _phoneController,
            onCodeChanged: (code) => registState.phoneCode = code.dialCode,
            onSaved: (String phone) => registState.setPhone(phone.trim()),
            countryCode: Selector<RegistState, String>(
              selector: (_, code) => code.phoneCode,
              builder: (_, phoneCode, __) {
                return Text(
                  phoneCode,
                  style: Theme.of(context).textTheme.subtitle2,
                );
              },
            ),
            initialCode: registState.phoneCode,
          ),
          SizedBox(height: 6),
          Row(
            children: [
              SizedBox(width: 10),
              Selector<RegistState, String>(
                selector: (_, e) => e.errorMessage,
                builder: (context, message, _) {
                  return Text(
                    message,
                    style: TextStyle(
                        color: Theme.of(context).errorColor, fontSize: 13),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text('Next'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
              // save phone error message to show it
              registState.errorMessage =
                  validation.phoneValidate(_phoneController.text.trim());

              validation.saveFormData(
                formState: formKey.currentState,
                phone: _phoneController.text.trim(),
                sendData: () async {
                  FirebaseUser user = await registState.autoRegistration(
                    pinPage: () {
                      Navigator.push<Widget>(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PhoneVerification(),
                        ),
                      );
                    },
                  );
                  Navigator.push<Widget>(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Home(userId: user.uid),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
