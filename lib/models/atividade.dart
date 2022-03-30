import 'package:flutter/material.dart';

class Atividade {
  final String titulo;
  final String descricao;
  final String dataCriacao;

  const Atividade({
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
  });

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
        titulo: json['titulo'],
        descricao: json['descricao'],
        dataCriacao: json['data_cricao']);
  }
}

@immutable
class AtividadeModel {
  final String titulo;
  final String descricao;
  final String dataCriacao;

  const AtividadeModel({
    this.titulo = '',
    this.descricao = '',
    this.dataCriacao = '',
  });

  AtividadeModel copyWith({
    String? titulo,
    String? descricao,
    String? dataCriacao,
  }) {
    return AtividadeModel(
        titulo: titulo ?? this.titulo,
        descricao: descricao ?? this.descricao,
        dataCriacao: dataCriacao ?? this.dataCriacao);
  }

  Map toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'data_cricao': dataCriacao,
    };
  }
}
