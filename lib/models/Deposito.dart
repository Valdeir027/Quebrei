class Deposito {
  int? id;
  int valor;
  DateTime dataDeposito;

  Deposito({this.id, required this.valor, required this.dataDeposito});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valor': valor,
      'dataDeposito': dataDeposito.toIso8601String(),
    };
  }

  factory Deposito.fromMap(Map<String, dynamic> map) {
    return Deposito(
      id: map['id'],
      valor: map['valor'],
      dataDeposito: DateTime.parse(map['dataDeposito']),
    );
  }
}
