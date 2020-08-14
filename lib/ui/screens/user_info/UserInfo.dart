import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../blocs/ui_providers/userInfo_ui.dart';

class UserInfo extends StatelessWidget {
  static const String id = "userInfo";
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => InfoUIState(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ToDo: image picker
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: theme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 30),
                  InfoFields(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoFields extends StatefulWidget {
  @override
  _InfoFieldsState createState() => _InfoFieldsState();
}

class _InfoFieldsState extends State<InfoFields> {
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    InfoUIState setLengths = Provider.of<InfoUIState>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Selector<InfoUIState, int>(
          selector: (_, userInfo) => userInfo.nameLength,
          builder: (context, length, _) {
            return TextFormField(
              decoration: InputDecoration(
                isDense: true,
                hintText: "Name",
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                counterText: '',
                suffixText: length == 30 ? null : '$length',
              ),
              onChanged: (val) => setLengths.nameLength = val.length,
              maxLength: 30,
            );
          },
        ),
        SizedBox(height: 10),
        Selector<InfoUIState, int>(
          selector: (_, userInfo) => userInfo.aboutLength,
          builder: (context, length, _) {
            return TextFormField(
              decoration: InputDecoration(
                isDense: true,
                hintText: "About",
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                counterText: '',
                suffixText: length == 120 ? null : '$length',
              ),
              onChanged: (val) => setLengths.aboutLength = val.length,
              maxLength: 130,
              minLines: 1,
              maxLines: 2,
            );
          },
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          child: RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
