import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../blocs/providers/registration/registration_state.dart';

class PhoneVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Text('Sync verification code', style: theme.textTheme.headline6),
              SizedBox(height: 15),
              Text(
                'Code will be expired after 1 minute',
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
                        onPressed: () {},
                      ),
                    )
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

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   RegistState registState = Provider.of<RegistState>(context);
  // }


  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obsecureText: false,
      autoFocus: true,
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
      // enableActiveFill: true,
      // errorAnimationController: errorController,
      onCompleted: (v) {
        print("Completed");
      },
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
  }
}
