import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_mobile_banking_system/ui/route/route.dart';

class Auth {
  final box = GetStorage();
  

  Future registration(String emailAddress, String password, context) async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      var authCredential = usercredential.user;
      print(authCredential);
      if (authCredential!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: 'registration Successfull');
        box.write('uid', authCredential.uid);
        Get.toNamed(userFormScreen);
      } else {
        print('Sign up failed');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error is : $e');
    }
  }

  Future login(emailAddress, password, context) async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      var authCredential = usercredential.user;
      print(authCredential);
      if (authCredential!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Login Successful');
        box.write('uid', authCredential.uid);
        box.write('phnum', authCredential.uid);
        Get.toNamed(pinLockScreen);
      } else {
        
        print('Sign In failed');
        Fluttertoast.showToast(msg: 'Sign In failed');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code ==  'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: 'Wrong password provided for that user.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error is : $e');
    }

     

    

    
  
  }
}
