import 'dart:convert';

import 'package:helping_nexus/api/extensions.dart';
import 'package:http/http.dart' show get, post, Response;

import '../models/message.dart';

class MessagesService {
  final String _baseUrl =
      'https://api.helpingnex.us/messages'; // dotenv.env['API_URL'] ?? '';
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

  Future getMessages({required String userId, required String wishId}) async {
    await init();
    final response = await get(
      Uri.parse('$_baseUrl?user_id=$userId&wish_id=$wishId'),
      headers: headers,
    );

    if (response.isSuccessful) {
      final List<dynamic> messages = jsonDecode(response.body);
      return messages.map((message) => Message.fromJson(message)).toList();
    }

    return null;
  }

  Future createMessage({
    required String message,
    required String fromUserId,
    required String toUserId,
    required String wishId,
  }) async {
    await init();
    final Response response = await post(
      Uri.parse('$_baseUrl/'),
      headers: headers,
      body: jsonEncode({
        'message': message,
        'from_user_id': fromUserId,
        'to_user_id': toUserId,
        'wish_id': wishId,
      }),
    );

    if (response.isSuccessful) {
      return Message.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}
