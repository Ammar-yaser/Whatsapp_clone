import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../blocs/providers/registration/registration_state.dart';

class PhoneVerification extends StatelessWidget {
  static const String id = "verification";
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    RegistState registState = Provider.of<RegistState>(context, listen: false);
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
              TimerText(),
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
                      child: Selector<RegistState, bool>(
                        selector: (_, registState) => registState.isTimeout,
                        builder: (context, isTimeout, _) {
                          return RaisedButton(
                            child: Text('Confirm'),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            onPressed: isTimeout ? () {
                              registState.maniualRegistration();
                            } : null,
                          );
                        }
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

class TimerText extends StatefulWidget {
  @override
  _TimerTextState createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start -= 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    Provider.of<RegistState>(context, listen: false).isTimeout = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sync sms code automaticaly in: $_start sec',
      style: Theme.of(context).textTheme.caption,
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
    return Selector<RegistState, Map<String, dynamic>>(
      selector: (_, registState) => {
        "pinCode": registState.autoCode,
        "timeout": registState.isTimeout,
      },
      builder: (context, getUpdates, _) {
        _pinController.text = getUpdates['pinCode'];
        return PinCodeTextField(
          length: 6,
          obsecureText: !getUpdates['timeout'],
          enabled: getUpdates['timeout'],
          autoDisposeControllers: false,
          controller: _pinController,
          textInputType: TextInputType.number,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            inactiveColor: Colors.blue,
            selectedColor: Theme.of(context).primaryColor,
            disabledColor: Colors.grey,
          ),
          textStyle: Theme.of(context).textTheme.subtitle2,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          onCompleted: (code) => registState.setSmsCode = code,
          onChanged: (value) {
            print(value);
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            return true;
          },
        );
      },
    );
  }
}
