import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class Auth {
  //singleton
  static final Auth _authInstance = Auth._internal();
  Auth._internal();
  static Auth get instance => _authInstance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn gogleSignIn = GoogleSignIn();
  final FacebookLogin fbLogin = FacebookLogin();

  Future<FirebaseUser> googleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await gogleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void googleSignOut() {
    gogleSignIn.signOut();
    print("User Signed out");
  }

  Future<FirebaseUser> fbSignIn() async {
    final result = await fbLogin.logInWithReadPermissions(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token);
      final FirebaseUser user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return user;
    } else if (result.status == FacebookLoginStatus.error) {
    } else if (result.status == FacebookLoginStatus.cancelledByUser) {}

    return null;
  }

  void fbSignOut() {
    fbLogin.logOut();
    print("User Signed out");
  }

  Future<FirebaseUser> emailPasswordLogin(String email, String password) async {
    FirebaseUser user;
    try {
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<FirebaseUser> emailPasswordSignUp(
      String email, String password) async {
    FirebaseUser user;
    try {
      user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }

    return user;
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    return;
  }

  Future<bool> forgotPassword(String email) async {
    bool sent = false;
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((onValue) {
        sent = true;
      }).catchError((onError) {
        sent = false;
      });
    } catch (e) {
      sent = false;
    }
    return sent;
  }

  Future<bool> checkUserData() async {
    Firestore fs = Firestore.instance;
    DocumentReference documentReference;
    fs.settings(persistenceEnabled: false);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser.providerData[1].email != null) {
      documentReference = fs
          .collection("users")
          .document("${currentUser.providerData[1].email}");
      var user = await documentReference.get();
      if (user.exists) return true;
    }
    return false;
  }

  Future<User> getUserData() async {
    User user;
    DocumentReference documentReference;
    Firestore fs = Firestore.instance;
    fs.settings(persistenceEnabled: false);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser.providerData[1].email != null) {
      documentReference = fs
          .collection("users")
          .document("${currentUser.providerData[1].email}");
      documentReference.get().then((datasnapshot) {
        if (datasnapshot.exists) {
          user = User.fromMap(datasnapshot.data);
        }
      });
    }
    return user;
  }

  void saveUserData(User user) async {
    DocumentReference documentReference;
    Firestore fs = Firestore.instance;
    fs.settings(persistenceEnabled: false);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser.providerData[1].email != null) {
      documentReference = fs
          .collection("users")
          .document("${currentUser.providerData[1].email}");

      documentReference.setData(user.toMap()).whenComplete(() {
        print("Document Added");
      }).catchError((e) => print(e));
    }
  }

  void delete() async {
    DocumentReference documentReference;
    Firestore fs = Firestore.instance;
    fs.settings(persistenceEnabled: false);
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser.providerData[1].email != null) {
      documentReference = fs
          .collection("users")
          .document("${currentUser.providerData[1].email}");
      documentReference.delete().whenComplete(() {
        print("Deleted Successfully");
      }).catchError((e) => print(e));
    }
  }

  void update(User user) async {
    DocumentReference documentReference;
    Firestore fs = Firestore.instance;
    
    fs.settings(persistenceEnabled: false);

//    fs.settings(timestampsInSnapshotsEnabled: true,persistenceEnabled: true);
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser.providerData[1].email != null) {
      documentReference = fs
          .collection("users")
          .document("${currentUser.providerData[1].email}");
      documentReference.updateData(user.toMap()).whenComplete(() {
        print("Document Updated");
      }).catchError((e) => print(e));
    }
  }
}
