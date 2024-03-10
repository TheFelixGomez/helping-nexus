import 'dart:convert';

import 'package:helping_nexus/api/extensions.dart';
import 'package:http/http.dart' show get, post;

import '../models/wish.dart';

class WishesService {
  final String _baseUrl =
      'https://api.helpingnex.us/wishes'; // dotenv.env['API_URL'] ?? '';
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

  Future createWish(Wish wish) async {
    await init();
    final response = await post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode(wish.toJson()),
    );

    return response;
  }

  Future getNewWishes({required String userId}) async {
    await init();
    final response = await get(
      Uri.parse('$_baseUrl/new?user_id=$userId'),
      headers: headers,
    );

    if (response.isSuccessful) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Wish.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load wishes');
    }
  }

  // propose to volunteer for a wish
  Future proposeToVolunteer({required String wishId, required String userId}) async {
    await init();
    final response = await post(
      Uri.parse('$_baseUrl/propose'),
      headers: headers,
      body: jsonEncode({'wishId': wishId, 'userId': userId}),
    );

    return response;
  }

  // propose a volunteer to a wish
  Future proposeVolunteer({required String wishId, required String userId}) async {
    await init();
    final response = await post(
      Uri.parse('$_baseUrl/propose-volunteer'),
      headers: headers,
      body: jsonEncode({'wish_id': wishId, 'user_id': userId}),
    );

    return response;
  }

  // reject a wish from a volunteer's pov
  Future rejectWish({required String wishId, required String userId}) async {
    await init();
    final response = await post(
      Uri.parse('$_baseUrl/reject'),
      headers: headers,
      body: jsonEncode({'wish_id': wishId, 'user_id': userId}),
    );

    return response;
  }

  // reject a volunteer from a wish's pov
  Future rejectVolunteer({required String wishId, required String userId}) async {
    await init();
    final response = await post(
      Uri.parse('$_baseUrl/reject-volunteer'),
      headers: headers,
      body: jsonEncode({'wish_id': wishId, 'user_id': userId}),
    );

    return response;
  }

}
