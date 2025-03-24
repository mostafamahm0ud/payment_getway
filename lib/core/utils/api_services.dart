import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio = Dio();

  Future<Response> postRequest(
      {required String url,
      required Map<String, dynamic> body,
      required String token,
      String? contentType}) async {
    try {
      final response = await dio.post(url,
          data: body,
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'Authorization': 'Bearer $token'},
          ));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
