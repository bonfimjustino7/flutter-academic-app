import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardAtividade extends StatelessWidget {
  final String titulo;
  final String dataCriacao;
  final String descricao;

  const CardAtividade({
    Key? key,
    required this.titulo,
    required this.descricao,
    required this.dataCriacao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateCreated = DateTime.parse(dataCriacao);

    DateFormat format = DateFormat('dd/MM/yyyy');

    String dateFormatted = format.format(dateCreated);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://blog.img.com.br/wp-content/uploads/2018/02/avatar-1577909_640.png',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dateFormatted,
                      style: const TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              descricao,
              style: const TextStyle(fontSize: 13, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
