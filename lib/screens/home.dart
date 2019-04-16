import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:updateproject/screens/service.dart';
import 'package:updateproject/screens/splash_screen.dart';
import 'package:updateproject/ui/ui.dart';
import 'package:updateproject/utility/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _familyNameController = TextEditingController();
  var _sureNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _msgTitleController = TextEditingController();
  var _howCanHelpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          body: body(),
          floatingActionButton: fab(context),
        ));
  }

  Future<bool> _onWillPop(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('تأكيد الخروج '),
                content: new Text(' هل انت متأكد من الخروج'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('الغاء'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('تأكيد'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  Widget body() {
    return ListView(
      children: <Widget>[
        appBar(),
        header(),
        header1(),
        header2(),
        header3(),
        header4(),
        header5(),
        header6(),
        header7(),
        header8(),
        header9(),
      ],
    );
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.all(11),
      child: Row(children: <Widget>[
        UI.button1(context, 'موقعنا', Colors.orange[600], null, 90, 45, () {
          launchURL('https://updategroup.net/');
        }),
        SizedBox(
          width: 2,
        ),
        UI.button1(context, 'مشاركة', Colors.orange[600], null, 90, 45, () {
          Share.share(
            """مرحبا بك لتحميل تطبيق ابديت جروب اندرويد برجاء الضغط على الرابط:\n https://play.google.com/store/apps/details?id=com.updategroupdevelopment.updategroup و للايفون برجاء الضغط على الرابط:\n http://itunes.apple.com/app/id1459775578
          """);
        }),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/images/logowide.png", // fit: BoxFit.cover,
              scale: 1.2,
            ),
          ),
        ),
      ]),
    );
    // AppBar(
    //   title: Row(
    //     children: <Widget>[
    //       Padding(padding: EdgeInsets.only(left: 57.0)),
    //       Image.asset(
    //         "assets/images/logo.png",
    //         width: 80.0,
    //         height: 70.0,
    //         fit: BoxFit.cover,
    //       ),
    //       Text(
    //         '  Update Group',
    //       )
    //     ],
    //   ),
    //   centerTitle: true,
    // );
  }

  header() {
    return Stack(children: <Widget>[
      Container(
        height: 600,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover)),
      ),
      Container(
        padding: EdgeInsets.only(top: 250),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(
                'للتطوير',
                style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                ' جروب',
                style: TextStyle(fontSize: 35, color: Colors.orange, fontWeight: FontWeight.bold),
              ),
              Text(
                ' ابديت',
                style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ]),
            Text(
              'أفضل و أجود الخدمات نضعها بين يديك',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  header1() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/about.jpg"), fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  'عـنـا',
                  style: TextStyle(fontSize: 28, color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' نبذة',
                  style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ]),
              Container(
                color: Colors.orange,
                width: 50,
                height: 2,
              ),
            ]),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text(
                'نحن فريق فني مختص في تجهيز المباني والمنشأت',
                style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              Text(
                'اعمال صيانة واعادة تأهيل وتشطيبات ودعم فني  ',
                style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              Text(
                'اعمال كهرباء وميكانيكا وتشطيبات. رضاك هدفنا   ',
                style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
            ]),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '   خدمات متنوعة و مختلفة',
                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                  Icon(
                    FontAwesomeIcons.check,
                    color: Colors.orange,
                    size: 17,
                  ),
                  Container(
                    width: 8,
                    height: 0,
                  )
                ],
              )
            ]),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '   طاقم عمل احترافي',
                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                  Icon(
                    FontAwesomeIcons.check,
                    color: Colors.orange,
                    size: 17,
                  ),
                  Container(
                    width: 8,
                    height: 0,
                  )
                ],
              )
            ]),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '   أسعار جدا مناسبة',
                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                  Icon(
                    FontAwesomeIcons.check,
                    color: Colors.orange,
                    size: 17,
                  ),
                  Container(
                    width: 8,
                    height: 0,
                  )
                ],
              )
            ]),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '   تواصل دائم 24/7',
                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                  Icon(
                    FontAwesomeIcons.check,
                    color: Colors.orange,
                    size: 17,
                  ),
                  Container(
                    width: 8,
                    height: 0,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  header2() {
    return UI.workBanner("assets/images/ElectricalSafetyBanner.jpg", 'الكهرباء');
  }

  header3() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: <Widget>[
            UI.roundedImg('assets/images/electricity.jpg'),
            UI.roundedImg('assets/images/solarenergy.jpg'),
            UI.roundedImg('assets/images/fire.jpg'),
            UI.roundedImg('assets/images/network.jpg'),
            UI.roundedImg('assets/images/camera.jpg'),
            UI.roundedImg('assets/images/tv.jpg'),
            UI.button(context, 'اطلب إحدى خدماتنـا الـآن', Colors.orange[600], null, 300, 120, () {
              UI.navigateTo(context, Service(), 0);
            })
          ],
        ));
  }

  header4() {
    return UI.workBanner("assets/images/mechanicalbanner.jpg", 'الميكانيكا');
  }

  header5() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: <Widget>[
            UI.roundedImg('assets/images/generator.jpg'),
            UI.roundedImg('assets/images/takyef.jpg'),
            UI.roundedImg('assets/images/pump.jpg'),
            UI.roundedImg('assets/images/waternetwork.jpg'),
            UI.roundedImg('assets/images/plump.jpg'),
            UI.roundedImg('assets/images/fireoff.jpg'),
            UI.button(context, 'اطلب إحدى خدماتنـا الـآن', Colors.orange[600], null, 300, 120, () {
              UI.navigateTo(context, Service(), 0);
            })
          ],
        ));
  }

  header6() {
    return UI.workBanner("assets/images/cleaningbanner.png", 'التشطيبات');
  }

  header7() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: <Widget>[
            UI.roundedImg('assets/images/mehara.jpg'),
            UI.roundedImg('assets/images/ceramic.jpg'),
            UI.roundedImg('assets/images/paint.jpg'),
            UI.roundedImg('assets/images/rokham.jpg'),
            UI.roundedImg('assets/images/ngara.jpg'),
            UI.roundedImg('assets/images/decor.jpg'),
            UI.roundedImg('assets/images/sa2f.jpg'),
            UI.roundedImg('assets/images/cleaning.jpg'),
            UI.roundedImg('assets/images/asas.jpg'),
            UI.button(context, 'اطلب إحدى خدماتنـا الـآن', Colors.orange[600], null, 300, 130, () {
              UI.navigateTo(context, Service(), 0);
            })
          ],
        ));
  }

  header8() {
    return Container(
      padding: EdgeInsets.only(left: 22, right: 22, top: 22, bottom: 15),
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/footer.png"), fit: BoxFit.fill)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  'التواصل',
                  style: TextStyle(fontSize: 27, color: Colors.black),
                ),
                Text(
                  ' معلومات',
                  style: TextStyle(fontSize: 27, color: Colors.black),
                ),
              ]),
              Container(
                color: Colors.orange,
                width: 80,
                height: 1.8,
              ),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 35)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '   مكة المكرمة. المملكة العربية السعودية',
                  style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
                Image.asset('assets/images/maplocation.png', width: 50, height: 50),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            GestureDetector(
              onTap: () {
                launchURL('tel:+966 59 897 9869');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '   9869 897 59 966+',
                    style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                  Image.asset('assets/images/phonereceiver.png', width: 50, height: 50, fit: BoxFit.contain),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            GestureDetector(
              onTap: () => launchURL('mailto:contact@updategroup.net?subject=&body='),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'contact@updategroup.net   ',
                    style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Image.asset('assets/images/mail.png', width: 50, height: 50),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                GestureDetector(
                    onTap: () => launchURL('https://www.instagram.com/mohamed_power_/'),
                    child: Image.asset('assets/images/Instagram.png', width: 55)),
                GestureDetector(
                    onTap: () => launchURL('https://www.facebook.com/ROUD-517484675423586/?ti=as'),
                    child: Image.asset('assets/images/facebook.png', width: 55)),
                GestureDetector(
                    onTap: () => launchURL('https://twitter.com/elrwoud?s=08'),
                    child: Image.asset('assets/images/Twitterpng.png', width: 55)),
                GestureDetector(
                    onTap: () => launchURL('https://api.whatsapp.com/send?phone=966598979869'),
                    child: Image.asset('assets/images/whatsapp.png', width: 55)),
              ],
            ),
          ]),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Text(
                    'تواصل معنا',
                    style: TextStyle(fontSize: 27, color: Colors.black),
                  ),
                  Container(
                    color: Colors.orange,
                    width: 80,
                    height: 1.8,
                  ),
                ]),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            color: Colors.white30,
            child: Column(
              children: <Widget>[
                inputField('الاسم العائلي', TextInputType.text, _familyNameController),
                Divider(height: 5.0),
                inputField('الاسم الشخصي', TextInputType.text, _sureNameController),
                Divider(height: 5.0),
                inputField('البريد الالكتروني', TextInputType.text, _emailController),
                Divider(height: 5.0),
                inputField('رقم الهاتف', TextInputType.number, _phoneController),
                Divider(height: 5.0),
                inputField('عنوان الرسالة', TextInputType.text, _msgTitleController),
                Divider(height: 5.0),
                inputField('كيف يمكننا مساعتدك؟', TextInputType.text, _howCanHelpController),
                Divider(height: 30.0),
                UI.button(context, 'إرسال', Colors.orange[600], null, 200, null, () {
                  if (_familyNameController.text.isEmpty ||
                      _sureNameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      !_emailController.text.contains('@') ||
                      !_emailController.text.contains('.') ||
                      _phoneController.text.isEmpty ||
                      _msgTitleController.text.isEmpty ||
                      _howCanHelpController.text.isEmpty) {
                    UI.dialog(context, 'خطأ', 'برجاءادخال البيانات المطلوبة', 'موافق');
                  } else {
                    launchURL(
                        'mailto:contact@updategroup.net?subject=${_msgTitleController.text}&body=${_howCanHelpController.text}\n\n\n${_sureNameController.text}%20${_familyNameController.text}\n${_emailController.text}\n${_phoneController.text}');
                  }
                }),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  width: 150,
                  child: GestureDetector(
                      onTap: () =>
                          launchURL('https://play.google.com/store/apps/details?id=com.updategroupdevelopment.updategroup'),
                      child: Image.asset('assets/images/googleplaybadge.png'))),
              Container(
                  width: 150,
                  child: GestureDetector(
                      onTap: () =>
                          launchURL('http://itunes.apple.com/app/id1459775578'),
                      child: Image.asset('assets/images/appstorebadge.png'))),
            ],
          ),
        ],
      ),
    );
  }

  header9() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      color: Colors.black87,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: Text(
            '2019 © جميع الحقوق محفوظة لـأبديت جروب للتطوير.',
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      UI.toast(context, 'Could not launch $url');
    }
  }

  Widget inputField(String hintText, TextInputType type, TextEditingController controller) {
    return new Container(
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
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    keyboardType: type,
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

  Widget fab(BuildContext context) {
    return FloatingActionButton(
        tooltip: 'تسجيل الخروج',
        child: Icon(FontAwesomeIcons.signOutAlt),
        onPressed: () {
          logOutConfirm(context);
        });
  }

  logOutConfirm(BuildContext context) {
    final alert = new AlertDialog(
      title: new Text('تسجيل الخروج'),
      content: new Text('؟هل انت متأكد من تسجيل الخروج'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: new Text('الغاء'),
        ),
        new FlatButton(
          onPressed: () async {
            Navigator.pop(context);
            await Auth.instance.signOut();
            UI.pushReplace(context, SplashScreen(), 0);
          },
          child: new Text('تأكيد'),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }
}
