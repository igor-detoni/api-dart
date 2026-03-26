import 'package:shelf/shelf.dart';

Middleware authMiddleware() {
  return (Handler innerHandler) {
    return (Request request) {
      final authHeader = request.headers['Authorization'];

      if (authHeader == '123' || authHeader == 'Bearer 123') {
        return innerHandler(request);
      }

      return Response.forbidden('Erro de acesso negado');
    };
  };
}