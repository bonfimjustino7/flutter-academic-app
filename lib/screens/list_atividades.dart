import 'dart:async';

import 'package:academic_app/models/atividade.dart';
import 'package:academic_app/screens/form_atividade.dart';
import 'package:academic_app/services/firebase.dart';
import 'package:flutter/material.dart';

class ListagemAtividades extends StatefulWidget {
  const ListagemAtividades({Key? key}) : super(key: key);

  @override
  State<ListagemAtividades> createState() => _ListagemAtividadesState();
}

class _ListagemAtividadesState extends State<ListagemAtividades> {
  List<Atividade> listagemVideos = [];
  bool _isLoading = false;
  final int _totalResults = 0;

  Future fetchAtividade() async {
    var response = await AtividadeService.list();
    return response;
  }

  void getAtividades() async {
    setState(() {
      _isLoading = true;
    });

    Map atividades = await fetchAtividade();

    atividades.forEach((key, value) {
      Atividade atividade = Atividade.fromJson(value);
      setState(() {
        listagemVideos.add(atividade);
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  Widget buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listagemVideos.length,
      itemBuilder: (context, index) {
        Atividade atividade = listagemVideos[index];

        if (index == listagemVideos.length - 1 &&
            _totalResults > listagemVideos.length) {
          return const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(atividade.titulo),
              subtitle: Text(atividade.dataCriacao),
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
