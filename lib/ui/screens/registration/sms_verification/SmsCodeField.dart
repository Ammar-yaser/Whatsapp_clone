import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../../blocs/providers/registration/registration_state.dart';

class SmsCodeField extends StatefulWidget {
  @override
  _SmsCodeFieldState createState() => _SmsCodeFieldState();
}

class _SmsCodeFieldState extends State<SmsCodeField> {
  TextEditingController _pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    return Selector<RegistState, bool>(
      selector: (_, registState) => registState.isTimeout,
      builder: (context, isTimeout, _) {
        return PinCodeTextField(
          controller: _pinController,
          length: 6,
          obsecureText: !isTimeout,
          enabled: isTimeout,
          autoDisposeControllers: false,
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
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            return true;
          },
          onChanged: (String value) {},
        );
      },
    );
  }
}
