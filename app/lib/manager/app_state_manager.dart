import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';

final appStateProvider = ChangeNotifierProvider<AppStateManager>((ref) => AppStateManager());

class AppStateManager extends ChangeNotifier {
  static const storage = FlutterSecureStorage();

  bool _initialized = false;
  bool _loggedIn = false;
  String? token;
  User? user;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  String? get getToken => token;
  User? get getUser => user;

  initializeApp() async {
    _initialized = true;
    notifyListeners();
  }

  login({required User user}) async {
    this.user = user;

    _loggedIn = true;

    notifyListeners();
  }
}