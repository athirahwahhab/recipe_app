import 'package:flutter/material.dart';

class genLoginSignupHeader extends StatelessWidget {
  String headerName;

  genLoginSignupHeader(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50.0),
          Text(
            headerName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[200],
                fontSize: 40.0),
          ),
          SizedBox(height: 10.0),
          Text(
            'Welcome',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[200],
                fontSize: 25.0),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}