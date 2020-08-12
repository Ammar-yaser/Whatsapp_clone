import 'package:flutter/material.dart';
import 'PhoneCode.dart';

class PhoneNumber extends StatelessWidget {
  final TextEditingController controller;
  final Function onSaved, onCodeChanged;
  final Widget countryCode;
  final String initialCode;

  const PhoneNumber({this.controller, this.onSaved, this.onCodeChanged, this.countryCode, this.initialCode});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: <Widget>[
            PhoneCode(
              onChanged: onCodeChanged,
              initialCode: initialCode,
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  isDense: false,
                  hintText: 'Phone number',
                  hintStyle: TextStyle(color: Colors.grey[300]),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 8.0,
                      right: 3,
                    ),
                    child: countryCode,
                  ),
                ),
                cursorColor: theme.primaryColor,
                style: TextStyle(fontSize: theme.textTheme.subtitle2.fontSize),
                keyboardType: TextInputType.number,
                onSaved: onSaved,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
