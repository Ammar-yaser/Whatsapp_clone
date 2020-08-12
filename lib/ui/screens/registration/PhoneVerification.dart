import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../services/auth_services.dart';
import '../../../blocs/providers/registration/registration_state.dart';

class PhoneVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    AuthServices authServices =
        Provider.of<AuthServices>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text('Sync verification code', style: theme.textTheme.headline6),
              SizedBox(height: 15),
              Text(
                'Sync sms code automaticaly in: 30 sec',
                style: theme.textTheme.caption,
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50),
                    PinCodeFields(),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text('Confirm'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        onPressed: registState.autoCode == null
                            ? null
                            : () {
                                authServices
                                    .signInWithOTP(registState.smsCode)
                                    .then((user) => user == null
                                        ? print('Failed signed in')
                                        : user.uid);
                              },
                      ),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PinCodeFields extends StatefulWidget {
  @override
  _PinCodeFieldsState createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    return Selector<RegistState, String>(
      selector: (_, registState) => registState.autoCode,
      builder: (context, autoCode, _) {
        _pinController.text = autoCode;
        return PinCodeTextField(
          length: 6,
          obsecureText: true,
          autoFocus: false,
          enabled: false,
          autoDisposeControllers: false,
          controller: _pinController,
          textInputType: TextInputType.number,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveColor: Colors.grey,
          ),
          textStyle: Theme.of(context).textTheme.subtitle2,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          onCompleted: (v) => registState.setSmsCode(v),
          onChanged: (value) {
            print(value);
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");

            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        );
      },
    );
  }
}

// Timer _timer;
//   int _start = 20;

//   void startTimer() {
//     const oneSec = const Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) => setState(
//         () {
//           if (_start < 1) {
//             timer.cancel();
//           } else {
//             _start -= 1;
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
