
abstract class ApiConsumer {
  Future<dynamic> post(
    String path, {

    dynamic data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> put(
    String path, {

    dynamic data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> patch(
    String path, {

    dynamic data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> delete(
    String path, {

    dynamic data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> get(
    String path, {
    dynamic data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  });
}
// class X{

//   c(){
//     Dio().get(qu)
//   }
// }