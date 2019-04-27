import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:simple_permissions/simple_permissions.dart';
import 'package:updateproject/screens/map.dart';
import 'package:updateproject/ui/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class Service extends StatefulWidget {
  final Widget child;

  Service({Key key, this.child}) : super(key: key);

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  // state variable
  String _service = 'تأسيس';
  String _radioValue = 'تـأسـيـس';
  void _handleRadioValueChange(String value) {
    setState(() {
      _radioValue = value;
      _service = _radioValue;
    });
  }

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _adressController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _describeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        decoration: background(),
        child: new ListView(
          children: <Widget>[
            header(),
            radio(),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: Text(':بيانات مقدم الطلب'))),
            inputField(
                '* رقم الهاتف', TextInputType.number, _phoneController, 1, true),
            Divider(height: 5.0),
            inputField('الاسم', TextInputType.text, _nameController, 1, true),
            Divider(height: 5.0),
            inputField('البريد الالكتروني', TextInputType.text,
                _emailController, 1, true),
            Divider(height: 5.0),
            inputField(
                'العنوان', TextInputType.text, _adressController, 1, false),
            addressInput(),
            Divider(height: 5.0),
            inputField('صف العمل المطلوب', TextInputType.text,
                _describeController, 4, true),
            SizedBox(
              height: 30,
            ),
            sendButton(),
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
        padding: EdgeInsets.only(top: 10.0),
        child: Container(
          width: 200,
          height: 120,
          child: Image.asset('assets/images/logowide.png'),
        ));
  }

  Widget radio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'صيـانـة',
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 12)),
            Text(
              'تركيبات عامة',
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 12)),
            Text(
              'دعـم فـنـي',
            ),
          ],
        ),
        Column(
          children: <Widget>[
            new Radio(
              value: 'صيـانـة',
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            new Radio(
              value: 'تركيبات عامة',
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            new Radio(
              value: 'دعـم فـنـي',
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
          ],
        ),
        Container(
          width: 40,
        ),
        Column(
          children: <Widget>[
            Text(
              'تـأسـيـس',
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 12)),
            Text(
              'أعمـال تشـطيبية',
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 12)),
            Text(
              'إعادة تـأهيـل',
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Radio(
              value: 'تـأسـيـس',
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            new Radio(
              value: 'أعمـال تشـطيبية',
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            new Radio(
              value: 'إعادة تـأهيـل',
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
          ],
        ),
      ],
    );
  }

  Widget inputField(String hintText, TextInputType type,
      TextEditingController controller, int lines, bool enabled) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.orange[700], width: 0.5, style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    enabled: enabled,
                    keyboardType: type,
                    maxLines: lines,
                    controller: controller,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget sendButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      margin: EdgeInsets.only(bottom: 30),
      child: UI.button(context, 'ارسال', Colors.orange, null, null, null,
          () async {
        if (_phoneController.text.isEmpty) {
          UI.dialog(context, 'خطأ', 'برجاءادخال البيانات المطلوبة', 'موافق');
        } else {
          launchURL(
              'mailto:contact@updategroup.net?subject=$_service&body=${_describeController.text}\n\n\n${_nameController.text}\n${_adressController.text}\n${_emailController.text}\n${_phoneController.text}');
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

  Widget addressInput() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: UI.button(context, 'أدخل العنوان', Colors.lightGreen,
          FontAwesomeIcons.mapMarkerAlt, null, 47, () async {
        getAdress();
      }),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      UI.toast(context, 'Could not launch $url');
    }
  }

  getAdress() async {
    bool granted = await requestPermission();
    if (granted) {
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
    } else {
      UI.dialog(
          context,
          'لا يوجد تصريح',
          ' لم يتم السماح لخدمة تحديد الموقع بالعمل, برجاء اعطاء التصريح حتى تتمكن من تحديد العنوان',
          'حاول مرة اخرى');
    }
  }

  Future<bool> requestPermission() async {
  //  Permission coarseLocation = Permission.AccessCoarseLocation;
  //  Permission fineLocation = Permission.AccessFineLocation;

  //  bool check1 = await SimplePermissions.checkPermission(coarseLocation);
  //  bool check2 = await SimplePermissions.checkPermission(fineLocation);
  // if (check1 || check2) {
  //    return true;
  // } else {
  //     PermissionStatus result1 =
  //         await SimplePermissions.requestPermission(coarseLocation);
  //     PermissionStatus result2 =
  //         await SimplePermissions.requestPermission(fineLocation);
  //     if (result1 == PermissionStatus.authorized ||
  //         result2 == PermissionStatus.authorized) return true;
  //     return false;
  //   }
   }
}
