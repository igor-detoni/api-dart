import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../database/database_helper.dart';
import '../models/produto.dart';

class ProdutoRoutes {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Router get router {
    final router = Router();

    router.get('/', (Request request) {
      final produtos = _dbHelper.getProdutos();
      final body = jsonEncode(produtos.map((p) => p.toMap()).toList());
      return Response.ok(body, headers: {'Content-Type': 'application/json'});
    });

    router.get('/<id>', (Request request, String id) {
      final produtoId = int.tryParse(id);
      if (produtoId == null) return Response.badRequest(body: 'ID inválido');

      final produto = _dbHelper.getProdutoById(produtoId);
      if (produto == null) return Response.notFound('Produto não encontrado');

      return Response.ok(jsonEncode(produto.toMap()), headers: {'Content-Type': 'application/json'});
    });

router.post('/', (Request request) async {
      final payload = await request.readAsString();
      final data = jsonDecode(payload);

      if (data is List) {
        List<int> idsCadastrados = [];
        for (var item in data) {
          if (item is Map && item.containsKey('nome') && item.containsKey('preco')) {
            final produto = Produto(nome: item['nome'], preco: (item['preco'] as num).toDouble());
            idsCadastrados.add(_dbHelper.insertProduto(produto));
          }
        }
        return Response(201, body: 'Produtos cadastrados com os IDs: $idsCadastrados');
      }

      if (data is Map) {
        if (!data.containsKey('nome') || !data.containsKey('preco')) {
           return Response.badRequest(body: 'Campos nome e preco obrigatórios');
        }
        final produto = Produto(nome: data['nome'], preco: (data['preco'] as num).toDouble());
        final id = _dbHelper.insertProduto(produto);
        return Response(201, body: 'Produto cadastrado com id $id');
      }

      return Response.badRequest(body: 'Formato de JSON inválido');
    });

    router.put('/<id>', (Request request, String id) async {
      final produtoId = int.tryParse(id);
      if (produtoId == null) return Response.badRequest(body: 'ID inválido');

      final payload = await request.readAsString();
      final data = jsonDecode(payload);

      final produtoExistente = _dbHelper.getProdutoById(produtoId);
      if (produtoExistente == null) return Response.notFound('Produto não encontrado');

      final produto = Produto(
        id: produtoId,
        nome: data['nome'] ?? produtoExistente.nome,
        preco: data['preco'] != null ? (data['preco'] as num).toDouble() : produtoExistente.preco
      );

      _dbHelper.updateProduto(produto);
      return Response.ok('Produto atualizado');
    });

    router.delete('/<id>', (Request request, String id) {
      final produtoId = int.tryParse(id);
      if (produtoId == null) return Response.badRequest(body: 'ID inválido');

      final produtoExistente = _dbHelper.getProdutoById(produtoId);
      if (produtoExistente == null) return Response.notFound('Produto não encontrado');

      _dbHelper.deleteProduto(produtoId);
      return Response.ok('Produto removido');
    });

    return router;
  }
}