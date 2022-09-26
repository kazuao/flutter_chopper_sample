import 'package:chopper/chopper.dart';
import 'mobile_data_interceptor.dart';
import 'package:built_collection/built_collection.dart';

import '../model/built_post.dart';
import 'built_value_converter.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  //抽象化
  // Headerを追加する場合1: @Get({'Content-Type': 'json'})
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: '/{id}')
  Future<Response<BuiltPost>> getPost(@Path('id') int id);
  // pathと@pathがつながる

  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: BuiltValueConverter(),
      interceptors: [
        // HeadersInterceptor({'Cache-Control': 'no-cache'}), // Headerをつけられる
        HttpLoggingInterceptor(), // Chopperのログを出力する際につける
        // CurlInterceptor(), // Curlコマンドのみ出力する

        // 特別なログを出す場合
        // 無名関数で書くか、クラス化する
        // (Request request) async {
        //   if (request.method == HttpMethod.Post) {
        //     chopperLogger.info('Performed a POST request');
        //   }
        //   return request;
        // },
        // (Response response) async {
        //   if (response.statusCode == 404) {
        //     chopperLogger.severe('404 NOT FOUND');
        //   }
        //   return response;
        // },

        // クラスとしてInterceptorを書いた場合
        MobileDataInterceptor(),
      ],
    );
    return _$PostApiService(client);
  }
}
// pub run commond: > flutter pub run build_runner watch
