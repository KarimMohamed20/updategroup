import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/home.dart';
import '../screens/register.dart';
import '../ui/ui.dart';
import '../utility/auth.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  bool _isSignInButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        decoration: background(),
        child: new ListView(
          children: <Widget>[
            header(),
            inputField(
                'البريد الاليكتروني', ' أدخل البريد ', _emailController, false),
            Divider(height: 24.0),
            inputField(
                "كلمة المرور", 'أدخل كلمة المرور', _passwordController, true),
            Divider(height: 24.0),
            forgotPassword(),
            signInButton(),
            registerButton(),
            separator(),
            signInwith(),
            SizedBox(
              height: 25,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration background() {
    return BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.06), BlendMode.dstATop),
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget header() {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
          width: 200,
          height: 150,
          child: Image.asset('assets/images/logowide.png'),
        ));
  }

  Widget inputField(String label, String hintText,
      TextEditingController controller, bool obscure) {
    return Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: new Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[600],
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.orange[700],
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextField(
                  obscureText: obscure,
                  controller: controller,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget forgotPassword() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: new FlatButton(
            child: new Text(
              "نسيت كلمة المرور؟",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange[600],
                fontSize: 15.0,
              ),
              textAlign: TextAlign.end,
            ),
            onPressed: () {
              _showDialog();
            },
          ),
        ),
      ],
    );
  }

  Widget signInButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: UI.button(
          context,
          'تسجيل دخول',
          Colors.orange[600],
          FontAwesomeIcons.userCheck,
          null,
          null,
          _isSignInButtonDisabled
              ? null
              : () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    UI.dialog(context, 'خطأ', 'برجاء ادخال البيانات المطلوبة',
                        'موافق');
                  } else {
                    setState(() {
                      _isSignInButtonDisabled = true;
                    });
                    final FirebaseUser user = await Auth.instance
                        .emailPasswordLogin(
                            _emailController.text, _passwordController.text);
                    final FirebaseUser currentUser =
                        await FirebaseAuth.instance.currentUser();
                    if (currentUser != null &&
                        user != null &&
                        user.uid == currentUser.uid) {
                      UI.pushReplace(context, Home(), 0);
                      UI.toast(context, 'تم الدخول بنجاح');
                    } else {
                      _emailController.clear();
                      _passwordController.clear();
                      _isSignInButtonDisabled = false;
                      UI.dialog(
                          context,
                          'البريد او كلمة المرور غير صحيحة',
                          'برجاء التأكد من البيانت و اعادة المحاولة',
                          'اعد المحاولة');
                    }
                  }
                }),
    );
  }

  Widget registerButton() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: UI.button(context, '‏إنشاء حساب', Colors.deepOrange[600],
          FontAwesomeIcons.userCircle, null, null, () {
        UI.navigateTo(context, Register(facebookGoogleRegister: false), 0);
      }),
    );
  }

  Widget separator() {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border.all(width: 0.25)),
            ),
          ),
          Text(
            "او قم بتسجيل الدخول بواسطة",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Expanded(
            child: new Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border.all(width: 0.25)),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInwith() {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          facebookSignIn(),
          googleSignIn(),
        ],
      ),
    );
  }

  Widget facebookSignIn() {
    return UI.button(
        context,
        'فيسبوك',
        Color(0Xff3B5998),
        FontAwesomeIcons.facebookF,
        MediaQuery.of(context).size.width / 2.5,
        null, () async {
      FirebaseUser user = await Auth.instance.fbSignIn();

      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      if (currentUser != null && user != null) {
        if (await Auth.instance.checkUserData()) {
          UI.toast(context, 'تم التسجيل بنجاح');
          UI.pushReplace(context, Home(), 0);
        } else {
          UI.toast(context, 'برجاء اكمال باقي البيانات');
          UI.navigateTo(context, Register(facebookGoogleRegister: true), 0);
        } 
      }else {
          UI.dialog(context, "خطأ", "اعد المحاولة", 'اعد');
        }
    });
  }

  Widget googleSignIn() {
    return UI.button(
        context,
        'جوجل',
        Color(0Xffdb3236),
        FontAwesomeIcons.google,
        MediaQuery.of(context).size.width / 2.5,
        null, () async {
      FirebaseUser user = await Auth.instance.googleSignIn();
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      if (currentUser != null && user != null) {
        if (await Auth.instance.checkUserData()) {
          UI.toast(context, 'تم التسجيل بنجاح');
          UI.pushReplace(context, Home(), 0);
        } else {
          UI.toast(context, 'برجاء اكمال باقي البيانات');
          UI.navigateTo(context, Register(facebookGoogleRegister: true), 0);
        } 
      }else {
          UI.dialog(context, "خطأ", "اعد المحاولة", 'اعد');
        }
    });
  }

  _showDialog() async {
    TextEditingController _emailController = TextEditingController();
    showDialog<String>(
        context: context,
        builder: (context) {
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    controller: _emailController,
                    decoration: new InputDecoration(
                        labelText: 'برجاء ادخال البريد', hintText: 'البريد'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('الغاء'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('ارسال'),
                  onPressed: () async {
                    if (_emailController.text.isEmpty ||
                        !_emailController.text.contains('@')) {
                      UI.toast(context, 'برجاء ادخال البريد');
                    } else {
                      if (await Auth.instance
                          .forgotPassword(_emailController.text)) {
                        UI.toast(
                            context, 'تم ارسال رسالة اعادة تعيين كلمة المرور');
                        Navigator.pop(context);
                      } else {
                        UI.toast(context, 'برجاء التأكد من البريد المكتوب');
                      }
                    }
                  })
            ],
          );
        });
  }
}
