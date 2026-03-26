class Produto {
  int? id;
  String nome;
  double preco;

  Produto({this.id, required this.nome, required this.preco});

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      preco: map['preco'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'preco': preco,
    };
  }
}