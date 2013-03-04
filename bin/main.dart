import 'dart:io';
import 'dart:json' as JSON;

main() {
  int defaultPort = 8080;
  var portStr = Platform.environment['PORT'];
  if (portStr == null)
    portStr = "";
  var port = int.parse(portStr, onError: (_) => defaultPort);
  
  HttpServer.bind('0.0.0.0', port).then((HttpServer server){
    print('Server started on port: ${port}');
    server.listen((HttpRequest request) {
      var resp = JSON.stringify({
        'Dart on Heroku': true,
        'Environment': Platform.environment}
      );
      request.response..headers.set(HttpHeaders.CONTENT_TYPE, 'application/json')
                      ..addString(resp)
                      ..close();
    });
  });
}
