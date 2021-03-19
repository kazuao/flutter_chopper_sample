import 'package:chopper/chopper.dart';

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
    );
    return _$PostApiService(client);
  }
}
// pub run commond: > flutter pub run build_runner watch
