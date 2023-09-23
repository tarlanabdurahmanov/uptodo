import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolistapp/firebase_options.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final Ref ref;

  AuthDataSource(this._firebaseAuth, this.ref);

  Future<Either<AppException, User>> signup(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(response.user!);
    } on FirebaseAuthException catch (e) {
      return Left(
        AppException(
          message: getMessageFromErrorCode(e.code),
          statusCode: 1,
          identifier: '${e.toString()}\nauth_data_source.signup',
        ),
      );
    }
  }

  Future<Either<AppException, User?>> login(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(response.user);
    } on FirebaseAuthException catch (e) {
      return Left(
        AppException(
          message: getMessageFromErrorCode(e.code),
          statusCode: 1,
          identifier: '${e.toString()}\nauth_data_source.login',
        ),
      );
    }
  }

  Future<Either<AppException, User>> continueWithGoogle() async {
    try {
      final googleSignIn =
          GoogleSignIn(clientId: DefaultFirebaseOptions.ios.iosClientId);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);
        return Right(response.user!);
      } else {
        return Left(
          AppException(
            message: "Unknow Error",
            statusCode: 1,
            identifier: 'auth_data_source.continueWithGoogle',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      return Left(
        AppException(
          message: e.message ?? 'Unknow Error',
          statusCode: 1,
          identifier: 'auth_data_source.continueWithGoogle',
        ),
      );
    }
  }

  String getMessageFromErrorCode(message) {
    switch (message) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      // ignore: unreachable_switch_case
      case "operation-not-allowed":
        return "Server error, please try again later.";
      // case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      case "INVALID_LOGIN_CREDENTIALS":
        return "Login failed. Please try again";
      default:
        return "Login failed. Please try again.";
    }
  }
}

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(ref.read(firebaseAuthProvider), ref),
);
