import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio = Dio();

  Future<Response> postRequest(
      {required String url,
      required Map<String, dynamic> body,
      required String token,
      Map<String, String>? headers,
      String? contentType}) async {
    try {
      final response = await dio.post(url,
          data: body,
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: headers ?? {'Authorization': 'Bearer $token'},
          ));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
