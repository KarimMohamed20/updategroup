import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UI {
  static Widget button(BuildContext context, String text, Color color, IconData icon, double width, double hieght, Function fun) {
    return Container(
      width: width == null ? MediaQuery.of(context).size.width : width,
      height: hieght,
      alignment: Alignment.center,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new FlatButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color: color,
              onPressed: fun,
              child: new Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 20
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    icon != null
                        ? Icon(
                            icon,
                            size: 18,
                            color: Colors.white,
                          )
                        : Wrap(),
                    new Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  static Widget button1(BuildContext context, String text, Color color, IconData icon, double width, double hieght, Function fun) {
    return Container(
      width: width == null ? MediaQuery.of(context).size.width : width,
      height: hieght,
      alignment: Alignment.center,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new FlatButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color: color,
              onPressed: fun,
              child: new Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    icon != null
                        ? Icon(
                            icon,
                            size: 18,
                            color: Colors.white,
                          )
                        : Wrap(),
                    new Container(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  static dialog(BuildContext context, String title, String msg, String buttonMsg) {
    var alert = new AlertDialog(
      title: new Text(title),
      content: new Text(msg),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(buttonMsg),
        )
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }

  static toast(BuildContext context, var txt) {
    Toast.show(txt, context,
        duration: 2, gravity: Toast.BOTTOM, textColor: Colors.black, backgroundColor: Colors.grey[400], backgroundRadius: 15);
    // Fluttertoast.showToast(
    //   msg: txt,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIos: 2,
    //   backgroundColor: Colors.grey[400],
    //   textColor: Colors.black,
    // );
  }

  static navigateTo(BuildContext context, Widget page, int duration) {
    new Future.delayed(
      Duration(seconds: duration),
      () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          ),
    );
  }

  static pushReplace(BuildContext context, Widget page, int duration) {
    new Future.delayed(
      Duration(seconds: duration),
      () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          ),
    );
  }

  static Widget workBanner(String imgPath, String label) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
        height: 150,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imgPath),
                colorFilter: ColorFilter.mode(Colors.black.withAlpha(200), BlendMode.multiply),
                fit: BoxFit.cover)),
      ),
      Center(
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 28, color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          Text(
            ' أعمال',
            style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    ]);
  }

  static Widget roundedImg(String path) {
    return Padding(
      padding: EdgeInsets.only(top: 18),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            path,
          )),
    );
  }
}
