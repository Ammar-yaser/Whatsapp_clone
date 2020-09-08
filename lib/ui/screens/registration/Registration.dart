import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/validators/FormsValidation.dart';
import 'package:whatsapp_clone/ui/screens/home/Home.dart';
import '../../../blocs/providers/registration/registration_state.dart';
import '../../widgets/PhoneNumber.dart';
import '../user_info/UserInfo.dart';
import 'sms_verification/smsVerification.dart';

class Registration extends StatelessWidget {
  static const String id = "registration";
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Selector<RegistState, bool>(
          selector: (context, registState) => registState.isLoading,
          builder: (context, isLoading, _) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                  child: Column(
                    children: [
                      Text('Enter your phone number',
                          style: theme.textTheme.headline6),
                      SizedBox(height: 15),
                      Text(
                        'We will send OTP code for verification your phone number',
                        style: theme.textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      RegistrationForm(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegistState registState = Provider.of<RegistState>(context, listen: false);
    FormsValidation validation =
        Provider.of<FormsValidation>(context, listen: false);

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
          Container(
            alignment: Alignment.center,
            child: Selector<RegistState, String>(
              selector: (_, e) => e.errorVerMessage,
              builder: (context, message, _) {
                return Text(
                  message,
                  style: TextStyle(
                      color: Theme.of(context).errorColor, fontSize: 13),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text('Next'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
              // save phone error message to show it
              String phone = _phoneController.text.trim();
              registState.errorVerMessage = validation.phoneValidate(phone);

              validation.saveFormData(
                formState: formKey.currentState,
                phone: phone,
                sendData: () async {
                  await registState.verifyPhone(
                    pinPage: () => Navigator.pushNamed(
                      context,
                      SmsVerification.id,
                    ),
                    onAutoRetrievComplete: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        registState.isNewUser ? UserInfoData.id : Home.id,
                        (Route route) => false,
                      );
                    },
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
