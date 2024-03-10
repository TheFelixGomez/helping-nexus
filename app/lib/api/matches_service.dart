import 'dart:convert';

import 'package:http/http.dart' show get;


class MatchesService {
  final String _baseUrl =
      'https://api.helpingnex.us/matches'; // dotenv.env['API_URL'] ?? '';
  String? _authToken;

  late Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${_authToken ?? ""}'
  };

  Future init() async {
    // Not read the token if is already saved in the instance.
    // if (_authToken != null) {
    //   return;
    // } else {
    //   // final container = ProviderContainer();
    //   // _authToken = await container.read(flutterSecureStorageProvider).read(key: "token");
    //
    //   if (_authToken == null) {
    //     return 'Can not init, because the user is not authenticated';
    //   }
    // }
  }

  // get all wishes matched for a user
  Future<List<dynamic>> getMatches({required String userId}) async {
    await init();
    final response = await get(
        Uri.parse('$_baseUrl?userId=$userId'),
        headers: headers
    );

    return jsonDecode(response.body);
  }

  // get all volunteers matched for a wish
  Future<List<dynamic>> getVolunteers({required String wishId}) async {
    await init();
    final response = await get(
        Uri.parse('$_baseUrl?wishId=$wishId'),
        headers: headers
    );

    return jsonDecode(response.body);
  }
}
