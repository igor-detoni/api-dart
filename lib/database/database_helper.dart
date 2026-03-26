import 'package:sqlite3/sqlite3.dart';
import '../models/produto.dart';

class DatabaseHelper {
  late final Database _db;

  DatabaseHelper() {
    _db = sqlite3.open('produtos.db');
    _initDb();
  }

  void _initDb() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        preco REAL NOT NULL
      )
    ''');
  }

  List<Produto> getProdutos() {
    final ResultSet resultSet = _db.select('SELECT * FROM produtos');
    return resultSet.map((row) => Produto.fromMap(row)).toList();
  }

  Produto? getProdutoById(int id) {
    final ResultSet resultSet = _db.select('SELECT * FROM produtos WHERE id = ?', [id]);
    if (resultSet.isEmpty) return null;
    return Produto.fromMap(resultSet.first);
  }

  int insertProduto(Produto produto) {
    _db.execute('INSERT INTO produtos (nome, preco) VALUES (?, ?)', [produto.nome, produto.preco]);
    return _db.lastInsertRowId;
  }

  void updateProduto(Produto produto) {
    _db.execute('UPDATE produtos SET nome = ?, preco = ? WHERE id = ?', [produto.nome, produto.preco, produto.id]);
  }

  void deleteProduto(int id) {
    _db.execute('DELETE FROM produtos WHERE id = ?', [id]);
  }
}