import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:simple_permissions/simple_permissions.dart';
import 'package:updateproject/models/user.dart';
import 'package:updateproject/screens/home.dart';
import 'package:updateproject/screens/map.dart';
import 'package:updateproject/ui/ui.dart';
import 'package:updateproject/utility/auth.dart';

class Register extends StatefulWidget {
  final bool facebookGoogleRegister;

  Register({Key key, @required this.facebookGoogleRegister}) : super(key: key);

  _RegisterState createState() => _RegisterState(facebookGoogleRegister);
}

class _RegisterState extends State<Register> {
  _RegisterState(this.facebookGoogleRegister);
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _adressController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  bool facebookGoogleRegister;

  @override
  void initState() {
    checkFGS();
    //initplatform();
    super.initState();
  }

  //its just for getting the platform version
  // initplatform() async {
  //   String platfrom;
  //   try {
  //     platfrom = await SimplePermissions.platformVersion;
  //   } on PlatformException {
  //     platfrom = "platform not found";
  //   }
  //   //if object is removed from the tree.
  //   if (!mounted) return;
  //   //otherwise set the platform to our _platformversion global variable
  //   // setState(() => _platformVersion = platfrom);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        decoration: background(),
        child: new ListView(
          children: <Widget>[
            header(),
            inputField('البريد الاليكتروني', ' أدخل البريد ', TextInputType.emailAddress, _emailController,
                facebookGoogleRegister, false),
            Divider(height: 15.0),
            facebookGoogleRegister
                ? Container(height: 0)
                : inputField(
                    "كلمة المرور", 'أدخل كلمة المرور', TextInputType.text, _passwordController, facebookGoogleRegister, true),
            Divider(height: 15.0),
            inputField('العنوان', 'العنوان', TextInputType.text, _adressController, true, false),
            addressInput(),
            Divider(height: 13.0),
            inputField('رقم الهاتف', ' أدخل رقم الهاتف ', TextInputType.phone, _phoneController, false, false),
            Divider(height: 13.0),
            registerButton(facebookGoogleRegister),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }

  checkFGS() async {
    if (facebookGoogleRegister) {
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      setState(() {
        print('register page :' + currentUser.providerData[1].email);
        _emailController.text = currentUser.providerData[1].email;
      });
    }
  }

  BoxDecoration background() {
    return BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.06), BlendMode.dstATop),
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

  Widget inputField(
      String label, String hintText, TextInputType type, TextEditingController controller, bool disabled, bool obscure) {
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
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.orange[700], width: 0.5, style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextField(
                  keyboardType: type,
                  enabled: disabled ? false : true,
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

  Widget registerButton(bool fgS) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: UI.button(context, 'تسجيل', Colors.deepOrange[600], FontAwesomeIcons.userCircle, null, null, () async {
        if (_emailController.text.isEmpty ||
            _adressController.text.isEmpty ||
            !_emailController.text.contains('@') ||
            !_emailController.text.contains('.') ||
            _adressController.text.length < 4) {
          UI.dialog(context, 'خطأ', 'برجاء التأكد من البيانات', 'موافق');
        } else {
          if (fgS) {
            registerSuccessful(
                _emailController.text, _adressController.text, _phoneController.text.isEmpty ? ' ' : _phoneController.text);
          } else {
            if (_passwordController.text.isEmpty || _passwordController.text.length < 6) {
              UI.dialog(context, 'برجاء ادخال كلمة مرور سليمة', 'تأكد من كلمة المرور ', 'اعد المحاولة');
            } else {
              FirebaseUser user = await Auth.instance.emailPasswordSignUp(_emailController.text, _passwordController.text);
              FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

              if (currentUser != null && user != null && user.uid == currentUser.uid) {
                UI.toast(context, 'تم التسجيل بنجاح');
                registerSuccessful(
                    _emailController.text, _adressController.text, _phoneController.text.isEmpty ? ' ' : _phoneController.text);
              } else {
                UI.dialog(context, 'برجاء ادخال بيانات سليمة',
                    'تأكد من كلمة المرور و ان البريد الذي تقوم بالتسجيل به ليس مسجل مسبقا', 'اعد المحاولة');
              }
            }
          }
        }
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
        ],
      ),
    );
  }

  registerSuccessful(String email, String adress, String phone) {
    final user = User(email: email, adress: adress.isEmpty ? ' ' : adress, phone: phone.isEmpty ? ' ' : phone);
    Auth.instance.saveUserData(user);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
  }

  Widget addressInput() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: UI.button(context, 'أدخل العنوان', Colors.lightGreen, FontAwesomeIcons.mapMarkerAlt, null, 47, () async {
        getAdress();
      }),
    );
  }

  getAdress() async {
   // bool granted = await requestPermission();
    // if (granted) {
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdressMap(),
          ));
      if (result != null) {
        print(result.toString());
        setState(() {
          _adressController.text = result.toString();
        });
      }
   // } else {
      UI.dialog(context, 'لا يوجد تصريح',
          ' لم يتم السماح لخدمة تحديد الموقع بالعمل, برجاء اعطاء التصريح حتى تتمكن من تحديد العنوان', 'حاول مرة اخرى');
   // }
  }

  // Future<bool> requestPermission() async {
  //   Permission coarseLocation = Permission.AccessCoarseLocation;
  //   Permission fineLocation = Permission.AccessFineLocation;

  //   bool check1 = await SimplePermissions.checkPermission(coarseLocation);
  //   bool check2 = await SimplePermissions.checkPermission(fineLocation);
  //   if (check1 || check2) {
  //     return true;
  //   } else {
  //     PermissionStatus result1 = await SimplePermissions.requestPermission(coarseLocation);
  //     PermissionStatus result2 = await SimplePermissions.requestPermission(fineLocation);
  //     if (result1 == PermissionStatus.authorized || result2 == PermissionStatus.authorized) return true;
  //     return false;
  //   }
  // }
}
