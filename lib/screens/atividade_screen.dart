import 'package:academic_app/models/atividade.dart';
import 'package:academic_app/shared/widgets/card_atividade.dart';
import 'package:flutter/material.dart';

class AtividadeScreen extends StatelessWidget {
  final Atividade atividade;

  const AtividadeScreen({Key? key, required this.atividade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(atividade.titulo)),
      backgroundColor: Colors.deepPurple[50],
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CardAtividade(
                titulo: atividade.titulo,
                descricao: atividade.descricao,
                dataCriacao: atividade.dataCriacao,
              ),
            ),
          ),
        );
      }),
    );
  }
}
