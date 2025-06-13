import 'dart:io';
import 'package:dio/dio.dart';
import 'package:down_detect/core/network/api_constants.dart';

class PredictionService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 20),
  ));

  Future<Map<String, dynamic>> predict(File imageFile) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path, filename: "upload.jpg"),
    });

    final response = await _dio.post(
      "${ApiConstants.predictUrl}/predict",
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );
    print('Response from API: ${response.data}');

    return response.data;
  }
}
