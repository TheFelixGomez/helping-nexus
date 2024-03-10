import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final appStateProvider = ChangeNotifierProvider<AppStateManager>((ref) => AppStateManager());

class AppStateManager extends ChangeNotifier {
  static const storage = FlutterSecureStorage();

  bool _initialized = false;
  bool _loggedIn = false;
  String? token;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  String? get getToken => token;

  initializeApp() async {
    token = await storage.read(key: 'token');

    await Future.delayed(const Duration(milliseconds: 2000));

    _initialized = true;

    if (token != null) {
      await login();

    } else {
      notifyListeners();
    }
  }

  login() async {
    _loggedIn = true;

    notifyListeners();
  }
}