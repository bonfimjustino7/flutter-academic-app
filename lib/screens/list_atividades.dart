import 'dart:async';

import 'package:academic_app/constants/form.dart';
import 'package:academic_app/models/atividade.dart';
import 'package:academic_app/screens/atividade_screen.dart';
import 'package:academic_app/screens/form_atividade.dart';
import 'package:academic_app/services/firebase.dart';
import 'package:academic_app/shared/widgets/card_atividade.dart';
import 'package:flutter/material.dart';

class ListagemAtividades extends StatefulWidget {
  const ListagemAtividades({Key? key}) : super(key: key);

  @override
  State<ListagemAtividades> createState() => _ListagemAtividadesState();
}

class _ListagemAtividadesState extends State<ListagemAtividades> {
  List<Atividade> listagemVideos = [];
  bool _isLoading = false;

  Future fetchAtividade() async {
    var response = await AtividadeService.list();
    return response;
  }

  void getAtividades() async {
    setState(() {
      _isLoading = true;
      listagemVideos = [];
    });

    Map? atividades = await fetchAtividade();
    if (atividades != null) {
      atividades.forEach((key, value) {
        Atividade atividade = Atividade.fromJson(value);
        setState(() {
          listagemVideos.add(atividade);
          listagemVideos.sort((a, b) {
            var d1 = DateTime.parse(a.dataCriacao);
            var d2 = DateTime.parse(b.dataCriacao);
            return d2.compareTo(d1);
          });
        });
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget buildList() {
    return listagemVideos.isEmpty
        ? const Center(
            child: Text('Nenhum tarefa encontrada'),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: listagemVideos.length,
            itemBuilder: (context, index) {
              Atividade atividade = listagemVideos[index];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AtividadeScreen(atividade: atividade),
                      ),
                    );
                  },
                  child: CardAtividade(
                    titulo: atividade.titulo,
                    dataCriacao: atividade.dataCriacao,
                    descricao: atividade.descricao
                        .substring(0, FormConstants.minDescricao),
                  ),
                ),
              );
            },
          );
  }

  @override
  void initState() {
    getAtividades();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atividades'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
        ),
        child: !_isLoading
            ? buildList()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormAtividade(),
            ),
          ).then((value) => getAtividades());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
