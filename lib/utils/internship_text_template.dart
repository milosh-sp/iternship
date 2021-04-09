import 'package:flutter/material.dart';
import 'image_banner.dart';

class InternDetails extends StatelessWidget {
  final String _title;
  final String _description;
  final String _tags;

  InternDetails(this._title, this._description, this._tags);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 4.0),
          child: Text(
            _title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 4.0),
          child: Text(_description),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 4.0),
          child: Text(
            _tags,
          ),
        ),
        RaisedButton(child: Text('Apply'), onPressed: () => print('applying '),)
      ],
    );
  }
}
