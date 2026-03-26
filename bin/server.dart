import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:api_produtos/middlewares/auth_middleware.dart';
import 'package:api_produtos/routes/produto_routes.dart';

void main() async {
  final router = Router();
  
  router.mount('/produtos', ProdutoRoutes().router.call);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleware())
      .addHandler(router.call);

  final server = await io.serve(handler, 'localhost', 8080);
  print('Servidor rodando em http://${server.address.host}:${server.port}');
}