import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';
import '../../blocs/providers/registration/registration_state.dart';

class PhoneCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegistState registState = Provider.of(context, listen: false);
    return CountryCodePicker(
      builder: (code) {
        return Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Image.asset(
                code.flagUri,
                package: 'country_code_picker',
                width: 25,
                height: 25,
              ),
              Icon(Icons.arrow_drop_down),
              VerticalDivider(width: 1, color: Colors.grey[300]),
            ],
          ),
        );
      },
      onChanged: (code) => registState.phoneCode = code.dialCode,
      initialSelection: 'EG',
      favorite: ['+20', 'EG'],
    );
  }
}
