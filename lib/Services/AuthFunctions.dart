import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:startupoderero/Services/FireStoreMethod.dart';


class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static String verifyId = "";
  // to sent and otp to user
  static Future sentOtp({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await _firebaseAuth
        .verifyPhoneNumber(
      timeout: Duration(seconds: 30),
      phoneNumber: "+91$phone",
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      verificationFailed: (error) async {
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        verifyId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  // verify the otp code and login
  static Future loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    try {
      final user = await _firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return "Success";
      } else {
        return "Error in Otp login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // to logout the user
  static Future logout() async {
    await _firebaseAuth.signOut();
  }

  // check whether the user is logged in or not
  static Future<bool> isLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }

  static Future Signup(String email, String password, String name, String DOB,
   String phoneNo,BuildContext context) async {
    try {
      print(email);
      print(password);
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FireStoreMethods().createUser(
        userId: credential.user!.uid,
        name: name ,
        email: email ,
        gender: '', // Add logic to determine gender if available
        profilePicture: '',
        // Fill other fields with empty strings for now
        dateOfBirth: DOB ,
        phoneNumber: phoneNo,
        occupation: '',
        state: '',
        district: '',
        bio: '',
       
        achievements: '',
           profession:'',
     Linkedin:'',
      Instagram:'',
       Youtube:'',
     Twitter:'',
      Facebook:'',
     GitHub:'',
     Contact:'',
     Address:'',
     website:'',
     portfolio:'',
     Resume:'',
     
     ShowLinkedin:false,
      ShowInstagram:false,
       ShowYoutube:false,
     ShowTwitter:false,
      ShowFacebook:false,
     ShowGitHub:false,
     ShowContact:false,
     ShowAddress:false,
     Showwebsite:false,
     Showportfolio:false,
     ShowResume:false,
        instagramLink: '',

        linkedinLink: '',
        IsVerified: false,
        context: context,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("hjbhjbeskjnkuesnjke$e");
    }
  }

  static Future Signin(String email, String password) async {
    try {
      print("////////////login///////////////");

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }


// static Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
  static Future<UserCredential> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print('google user $googleUser');

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'google_signin_failed',
          message: 'Google sign-in failed or was canceled.',
        );
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw FirebaseAuthException(
          code: 'user_not_found',
          message: 'User not found after Google sign-in.',
        );
      }

      // Extract user information from googleUser and create a UserModel instance
     await FireStoreMethods().createUser(
        userId: userCredential.user!.uid,
        name: googleUser!.displayName ?? '',
        email: googleUser.email ?? '',
        gender: '', // Add logic to determine gender if available
        profilePicture: googleUser.photoUrl ?? '',
        // Fill other fields with empty strings for now
        dateOfBirth: '',
        phoneNumber: '',
        occupation: '',
        state: '',
        district: '',
        bio: '',
        achievements: '',
        instagramLink: '',
        linkedinLink: '',
           profession:'',
     Linkedin:'',
      Instagram:'',
       Youtube:'',
     Twitter:'',
      Facebook:'',
     GitHub:'',
     Contact:'',
     Address:'',
     website:'',
     portfolio:'',
     Resume:'',
     
     ShowLinkedin:false,
      ShowInstagram:false,
       ShowYoutube:false,
     ShowTwitter:false,
      ShowFacebook:false,
     ShowGitHub:false,
     ShowContact:false,
     ShowAddress:false,
     Showwebsite:false,
     Showportfolio:false,
     ShowResume:false,
      
                            
        IsVerified: false,
        context: context, 
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Error signing in with Google: $e');
      throw e; // Rethrow the error for higher-level error handling
    }
  }
  //   static Future<UserCredential> signInWithGoogle(BuildContext context) async {


      
    
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn()
  //     ;
  //     print("Google Auth$googleUser");

  //     if (googleUser == null) {
  //       throw FirebaseAuthException(
  //         code: 'google_signin_failed',
  //         message: 'Google sign-in failed or was canceled.',
  //       );
  //     }

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     if (userCredential.user == null) {
  //       throw FirebaseAuthException(
  //         code: 'user_not_found',
  //         message: 'User not found after Google sign-in.',
  //       );
  //     }

  //     // Extract user information from googleUser and create a UserModel instance
  //     await FireStoreMethods().createUser(
  //       userId: userCredential.user!.uid,
  //       name: googleUser.displayName ?? '',
  //       email: googleUser.email ?? '',
  //       gender: '', // Add logic to determine gender if available
  //       profilePicture: googleUser.photoUrl ?? '',
  
  //       dateOfBirth: '',
  //       phoneNumber: '',
  //       occupation: '',
  //       state: '',
  //       district: '',
  //       bio: '',
  //       achievements: '',
  //       instagramLink: '',
  //       linkedinLink: '',
  //       IsVerified: false,
  //       context: context,
  //     );

  //     // return await userCredential;
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
   
  // }

  

  static Future<void> signOut() async {
    try {
      
      await FirebaseAuth.instance.signOut();
      
      print('User signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
