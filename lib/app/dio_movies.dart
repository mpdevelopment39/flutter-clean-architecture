import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'constants.dart';

class DioMovies {
  final Dio _dio = Dio();

  Dio get dio {
    return _dio;
  }

  DioMovies() {
    _dio.options.baseUrl = '';
    _dio.options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key' : movieDBApiKey,
        'language' : 'es-ES'
      }
    );
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.interceptors.add(PrettyDioLogger(requestBody: true));
  }
}
