import 'package:chopper/chopper.dart';
import 'package:flutter_chopper_sample/data/mobile_data_interceptor.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  // Headerを追加する場合1: @Get({'Content-Type': 'json'})
  @Get()
  Future<Response> getPosts();

  @Get(path: '/{id}')
  Future<Response> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HeadersInterceptor({'Cache-Control': 'no-cache'}), // Headerをつけられる
        // HttpLoggingInterceptor(), // Chopperのログを出力する際につける
        CurlInterceptor(), // Curlコマンドのみ出力する
        // 特別なログを出す場合
        // 無名関数で書くか、クラス化する
        (Request request) async {
          if (request.method == HttpMethod.Post) {
            chopperLogger.info('Performed a POST request');
          }
          return request;
        },
        (Response response) async {
          if (response.statusCode == 404) {
            chopperLogger.severe('404 NOT FOUND');
          }
          return response;
        },
        MobileDataInterceptor(),
      ],
    );
    return _$PostApiService(client);
  }
}
// pub run commond: > flutter pub run build_runner watch
