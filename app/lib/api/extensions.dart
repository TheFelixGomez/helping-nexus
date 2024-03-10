import 'package:http/http.dart' show Response;

extension IsSuccessful on Response {
  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
  bool get isServerError => statusCode >= 500;
}