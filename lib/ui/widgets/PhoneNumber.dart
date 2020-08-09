import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/blocs/providers/registration/registration_state.dart';

import 'PhoneCode.dart';

class PhoneNumber extends StatelessWidget {
  final TextEditingController controller;
  final Function onSaved;

  const PhoneNumber({this.controller, this.onSaved});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          PhoneCode(),
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
                  child: Selector<RegistState, String>(
                    selector: (_, registState) => registState.phoneCode,
                    builder: (_, phoneCode, __) {
                      return Text(
                        phoneCode,
                        style: theme.textTheme.subtitle2,
                      );
                    },
                  ),
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
    );
  }
}
