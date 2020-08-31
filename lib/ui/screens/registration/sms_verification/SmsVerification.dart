import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/api_response.dart';
import '../../../../blocs/providers/registration/registration_state.dart';
import 'SmsCodeField.dart';
import '../../user_info/UserInfo.dart';

class SmsVerification extends StatelessWidget {
  static const String id = "verification";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Selector<RegistState, bool>(
        selector: (context, registState) => registState.isLoading,
        builder: (context, isLoading, _) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: SmsVerBody(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SmsVerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
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
              SmsCodeField(),
              SizedBox(height: 40),
              SmsConfirmCode(),
            ],
          ),
        )
      ],
    );
  }
}

class SmsConfirmCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    return Container(
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
            onPressed: isTimeout
                ? () async {
                    ApiResponse<User> response =
                        await registState.maniualRegistration();
                    confirmBtn(context, response, registState.verifyPhone());
                  }
                : null,
          );
        },
      ),
    );
  }

  void confirmBtn(
      context, ApiResponse<User> response, Future<void> resend) {
    if (response.error) {
      if (response.errorMessage.contains('re-send')) {
        showBottomSheet(
          context: context,
          builder: (_) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              color: Colors.black12,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      response.errorMessage,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FlatButton(
                    child: Text('Re-send'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      await resend;
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Text('${response.errorMessage}'),
            ),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInfoData.id,
        (Route route) => false,
      );
    }
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
