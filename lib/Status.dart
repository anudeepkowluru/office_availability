import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  final String status;
  final String statusColor;
  Status(this.status, this.statusColor);

  @override
  State createState() => new _StatusPageState();
}

class _StatusPageState extends State<Status> {
  Widget status() {
    if (widget.status == 'Available') {
      return new InkWell(
        child: new Container(
          padding: new EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 0.0),
          color: Colors.green,
          child: new Text(
            'Available!',
            style: new TextStyle(
                fontFamily: 'Product Sans',
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 70.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else if (widget.status == 'Away') {
      return new InkWell(
        child: new Container(
          padding: new EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 0.0),
          color: Colors.yellowAccent,
          child: new Text(
            'Away',
            style: new TextStyle(
                fontFamily: 'Product Sans',
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 100.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else if (widget.status == 'Busy') {
      return new InkWell(
        child: new Container(
          padding: new EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 0.0),
          color: Colors.redAccent,
          child: new Text(
            'Busy.',
            style: new TextStyle(
                fontFamily: 'Product Sans',
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 100.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }else if (widget.status == 'Do Not Disturb') {
      return new InkWell(
        child: new Container(
          padding: new EdgeInsets.fromLTRB(10.0, 200.0, 0.0, 0.0),
          color: Colors.red,
          child: new Text(
            'Do Not Disturb.',
            style: new TextStyle(
                fontFamily: 'Product Sans',
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 100.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: status(),
      ),
    );
  }
}
