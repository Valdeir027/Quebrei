import 'package:flutter/material.dart';

class Conta {
  int? id; // Adicionar o campo id
  final double saldo;

  Conta({
    this.id,
    required this.saldo,
  });

  // Método para converter um JSON para um objeto Conta
  factory Conta.fromJson(Map<String, dynamic> json) {
    return Conta(
      id: json['id'],
      saldo: json['saldo'].toDouble(),
    );
  }

  // Método para converter um objeto Conta para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'saldo': saldo,
    };
  }

  // Método para converter um objeto Conta para um Map que será usado pelo SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saldo': saldo,
    };
  }

  // Método para criar um objeto Conta a partir de um Map do SQLite
  factory Conta.fromMap(Map<String, dynamic> map) {
    return Conta(
      id: map['id'],
      saldo: map['saldo'],
    );
  }
}
