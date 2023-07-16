import 'package:fashion_app/core/errors/exceptions.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/data/remote/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<User?> singUpFirebase(
      String username, String email, String password) async {
    try {
      final user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      await user?.updateDisplayName(username);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(message: AppStrings.passwordProvidedWeak);
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(message: AppStrings.accountAlreadyExists);
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  @override
  Future<User?> loginFirebase(String email, String password) async {
    try {
      return (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(message: AppStrings.userNotFound);
      } else if (e.code == 'wrong-password') {
        throw AuthException(message: AppStrings.wrongPassword);
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  @override
  signOutFirebase() async {
    await auth.signOut();
  }

  @override
  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the User
    return (await auth.signInWithCredential(credential)).user;
  }

  @override
  Future<User?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the User
    return (await auth.signInWithCredential(facebookAuthCredential)).user;
  }

  @override
  Future<void> verifyPhoneNumber(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          throw AuthException(message: AppStrings.invaildPhoneNumber);
        }
        // Handle other errors
      },
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  User? get getUserProfile {
    return auth.currentUser;
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = getUserProfile;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      return;
    }
  }

  @override
  Future<void> updatePassword(String password) async {
    final user = getUserProfile;
    if (user != null) {
      await user.updatePassword(password);
    } else {
      return;
    }
  }

  @override
  Future<void> updateUsername(String username) async {
    final user = getUserProfile;
    if (user != null) {
      await user.updateDisplayName(username);
    } else {
      return;
    }
  }

  @override
  Future<void> updateProfileImage(String image) async {
    final user = getUserProfile;
    if (user != null) {
      await user.updatePhotoURL(image);
    } else {
      return;
    }
  }

  @override
  String? get getUserId => auth.currentUser?.uid;

  @override
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = getUserProfile;
      if (user != null) {
        await user.updateEmail(newEmail);
      } else {
        return;
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? e.toString());
    }
  }

  @override
  Future<void> reAuthenticatesUser(String email, String password) async {
    User? user = auth.currentUser;

    if (user != null) {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      try {
        await user.reauthenticateWithCredential(credential);
        // User has been successfully reauthenticated
      } on FirebaseAuthException catch (e) {
        throw AuthException(message: e.message ?? e.toString());
      }
    }
  }
}
