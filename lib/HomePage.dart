import 'package:flutter/material.dart';
import 'dart:io';
import 'services/storage.dart';
import 'Status.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _platformVersion = 'Unknown';
  Map<String, String> fileContent;
  Storage dataStorage;
  File jsonFile;
  Directory dir;
  bool fileExists = false;
  String cartItems;

  @override
  void initState() {
    super.initState();
    Storage ds = new Storage();
    dataStorage = ds.getInstance();
  }

  // Widget
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        // appBar
        appBar: new AppBar(
          backgroundColor: Colors.white30,
          title: new Text("OFFICE AVAILABILITY",
              style: new TextStyle(
                  fontFamily: 'Product Sans',
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.account_circle),
              // onPressed: () {
              //   Navigator.of(context).push(new MaterialPageRoute(
              //       builder: (BuildContext context) => new LoginPage()));
              // },
            ),
          ],
        ),
        // drawer
        drawer: new Drawer(
            child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                "Anudeep Kowluru",
                style: new TextStyle(
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              accountEmail: new Text(
                "anudeep.kowluru@nih.gov",
                style: new TextStyle(
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              currentAccountPicture: new GestureDetector(
                // onTap: () {
                //   Navigator.of(context).push(new MaterialPageRoute(
                //       builder: (BuildContext context) => new LoginPage()));
                // },
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      "https://s3.amazonaws.com/desi-eats-dev/users/IMG_20180414_163107.jpg"),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.blueGrey
                  // image: new DecorationImage(
                  //     fit: BoxFit.cover,
                  //     image: new NetworkImage(
                  //         "http://neos-xapps-dev-s3bucketforwebsitecontent-1n4lc2awh3ps4.s3.amazonaws.com/NITAAC-Logo-Reimagine-LightBG_white_bg.png"))
                  ),
            ),
            new ListTile(
              leading: new Icon(Icons.schedule),
              title: new Text("Schedule",
                  style: new TextStyle(
                      fontFamily: 'Product Sans',
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)),
            ),
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.storage),
              title: new Text("Presets",
                  style: new TextStyle(
                      fontFamily: 'Product Sans',
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Settings",
                  style: new TextStyle(
                      fontFamily: 'Product Sans',
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)),
              leading: new Icon(Icons.settings),
            ),
            new ListTile(
              title: new Text("Logout",
                  style: new TextStyle(
                      fontFamily: 'Product Sans',
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)),
              leading: new Icon(Icons.cloud_off),
            ),
          ],
        )),
        // Body
        body: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Text('STATUS:',
                style: new TextStyle(
                    fontFamily: 'Product Sans',
                    letterSpacing: 2.0,
                    color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500)),
            new InkWell(
                onTap: () => goToStatusPage('Available', 'green'),
                child: new Card(
                    elevation: 10.0,
                    child: new Container(
                      padding: new EdgeInsets.fromLTRB(100.0, 40.0, 0.0, 0.0),
                      width: 440.0,
                      height: 124.0,
                      color: Colors.green[600],
                      child: new Text('Available',
                          style: new TextStyle(
                              fontFamily: 'Product Sans',
                              letterSpacing: 2.0,
                              color: Colors.black,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w500)),
                    ))),
            new InkWell(
                onTap: () => goToStatusPage('Away', 'yellowAccent'),
                child: new Card(
                    elevation: 10.0,
                    child: new Container(
                      padding: new EdgeInsets.fromLTRB(140.0, 40.0, 0.0, 0.0),
                      width: 440.0,
                      height: 124.0,
                      color: Colors.yellowAccent,
                      child: new Text('Away',
                          style: new TextStyle(
                              fontFamily: 'Product Sans',
                              letterSpacing: 2.0,
                              color: Colors.black,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w500)),
                    ))),
            new InkWell(
                onTap: () => goToStatusPage('Busy', 'redAccent'),
                child: new Card(
                    elevation: 10.0,
                    child: new Container(
                      padding: new EdgeInsets.fromLTRB(140.0, 40.0, 0.0, 0.0),
                      width: 440.0,
                      height: 124.0,
                      color: Colors.redAccent,
                      child: new Text('Busy',
                          style: new TextStyle(
                              fontFamily: 'Product Sans',
                              letterSpacing: 2.0,
                              color: Colors.black,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w500)),
                    ))),
            new InkWell(
                onTap: () => goToStatusPage('Do Not Disturb', 'red'),
                child: new Card(
                    elevation: 10.0,
                    child: new Container(
                      padding: new EdgeInsets.fromLTRB(60.0, 40.0, 0.0, 0.0),
                      width: 440.0,
                      height: 124.0,
                      color: Colors.red,
                      child: new Text('Do Not Disturb',
                          style: new TextStyle(
                              fontFamily: 'Product Sans',
                              letterSpacing: 2.0,
                              color: Colors.black,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w500)),
                    ))),
            new Divider(),
            new Text('PRESETS:',
                style: new TextStyle(
                    fontFamily: 'Product Sans',
                    letterSpacing: 2.0,
                    color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500)),
            new Text('Coming Soon!',
                style: new TextStyle(
                    fontFamily: 'Product Sans',
                    letterSpacing: 2.0,
                    color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500)),
            new Divider(),
            new Text('Built this app in 2 hours using Flutter!',
                style: new TextStyle(
                    fontFamily: 'Product Sans',
                    letterSpacing: 2.0,
                    color: Colors.black54,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500)),
            new Text('By AK.',
                style: new TextStyle(
                    fontFamily: 'Product Sans',
                    letterSpacing: 2.0,
                    color: Colors.black54,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500)),
          ],
        ));
  }

  goToStatusPage(status, statusColor) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new Status(status, statusColor)));
  }
}
