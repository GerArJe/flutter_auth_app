import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSigninService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account?.authentication;

      // print(account);
      // print('========= ID TOKEN =========');
      // print(googleKey?.idToken);
      final signWithGoogleEndpoint = Uri(
        scheme: 'https',
        host: 'apple-google-sign-in-flutter-t.herokuapp.com',
        path: '/google',
      );
      final session = await http.post(signWithGoogleEndpoint, body: {
        'token': googleKey?.idToken,
      });

      print('========= backend =========');
      print(session.body);

      return account;
    } catch (e) {
      print('Error en Google SignIn');
      print(e);
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}
