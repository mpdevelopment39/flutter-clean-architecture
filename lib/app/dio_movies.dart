import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'constants.dart';

//* Clase para gestionar las requests contra back/api...
//* Al solo haber un único origen de datos podemos definir directamente aquí las bases para todas las requests
//* Si tuvieramos diversas fuentes podríamos cambiar en la implementación directamente en los repos o tener una instancia de Dio por fuente de datos
class DioMovies {
  final Dio _dio = Dio();

  Dio get dio => _dio;

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
