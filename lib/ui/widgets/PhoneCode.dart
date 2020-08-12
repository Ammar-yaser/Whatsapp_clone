import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';


class PhoneCode extends StatelessWidget {

  final Function onChanged;
  final String initialCode;
  const PhoneCode({@required this.onChanged, this.initialCode});

  @override
  Widget build(BuildContext context) {
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
      onChanged: onChanged,
      initialSelection: CountryCode(code: initialCode).code,
      favorite: ['+20', 'EG'],
    );
  }
}

