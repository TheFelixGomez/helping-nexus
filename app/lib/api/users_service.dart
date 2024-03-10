import 'dart:convert';

import 'package:helping_nexus/api/extensions.dart';
import 'package:http/http.dart' show get, post, Response;

import '../models/location.dart';
import '../models/user.dart';

class UsersService {
  final String _baseUrl =
      'https://api.helpingnex.us/users'; // dotenv.env['API_URL'] ?? '';
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

  Future getUser({required String userId}) async {
    await init();
    final response = await get(
      Uri.parse('$_baseUrl/$userId'),
      headers: headers,
    );

    if (response.isSuccessful) {
      return User.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  Future createUser({
    required String email,
    required String firstName,
    required String lastName,
    String? phone,
    required String dob,
    required Location location,
    bool wisher = false,
    String? companyName,
    String? description,
  }) async {
    await init();
    final Response response = await post(
      Uri.parse('$_baseUrl/'),
      headers: headers,
      body: json.encode({
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'dob': dob,
        'location': location.toJson(),
        'wisher': wisher,
        'company_name': companyName,
        'description': description,
        'auth_id': 'auth0|60e3e3e3e3e3e3e3e3e3e3e3',
      }),
    );

    return response;
  }

  Future uploadProfilePicture({required String userId, required String image}) async {
    await init();

    final map = <String, dynamic>{};
    map['profile_picture'] = image;
    map['user_id'] = userId;

    final Response response = await post(
      Uri.parse('$_baseUrl/profile-picture'),
      body: map,
    );

    return response;
  }

  Future getProfilePicture({required String userId}) async {
    await init();
    final response = await get(
      Uri.parse('$_baseUrl/profile-picture?user_id=$userId'),
      headers: headers,
    );

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}
