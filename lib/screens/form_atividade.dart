import 'package:academic_app/constants/form.dart';
import 'package:academic_app/models/atividade.dart';
import 'package:academic_app/services/firebase.dart';
import 'package:academic_app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormAtividade extends StatefulWidget {
  const FormAtividade({Key? key}) : super(key: key);

  @override
  State<FormAtividade> createState() => _FormAtividadeState();
}

class _FormAtividadeState extends State<FormAtividade> {
  TextEditingController intialdateval = TextEditingController();
  DateTime? picked;
  final _form = GlobalKey<FormState>();

  var atividade = const AtividadeModel();
  bool _loadingButton = false;

  @override
  Widget build(BuildContext context) {
    Future _selectDate() async {
      picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050),
      );

      final DateFormat formatter = DateFormat('dd/MM/yyyy');

      if (picked != null) {
        setState(() {
          final String formatted = formatter.format(picked!);
          intialdateval.text = formatted;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Atividade')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Container(
                decoration: BoxDecoration(color: Colors.deepPurple[50]),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        CustomTextField(
                            validator: (text) => null,
                            labelText: 'Título',
                            hintText: 'Título',
                            onSaved: (text) =>
                                atividade = atividade.copyWith(titulo: text)),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          validator: (text) {
                            if (text != null &&
                                text.length < FormConstants.minDescricao) {
                              return 'Digite no mínimo ${FormConstants.minDescricao} caracteres';
                            }
                            return null;
                          },
                          labelText: 'Descrição',
                          hintText: 'Descrição',
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          onSaved: (text) =>
                              atividade = atividade.copyWith(descricao: text),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onSaved: (text) {
                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');

                            if (picked != null) {
                              final String formatted =
                                  formatter.format(picked!);

                              atividade =
                                  atividade.copyWith(dataCriacao: formatted);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Data inválida';
                            }
                            return null;
                          },
                          controller: intialdateval,
                          decoration: const InputDecoration(
                              labelText: 'Data da Tarefa',
                              border: OutlineInputBorder()),
                          onTap: () async {
                            _selectDate();
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              final isValid = _form.currentState?.validate();

                              if (isValid != null && isValid) {
                                _form.currentState?.save();
                                _saveForm();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _loadingButton
                                    ? Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                const Text('Salvar'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveForm() async {
    Map data = atividade.toJson();

    setState(() {
      _loadingButton = true;
    });
    try {
      await AtividadeService.save(data);
      Navigator.pop(context);
      setState(() {
        _loadingButton = false;
      });
    } catch (e) {
      setState(() {
        _loadingButton = false;
      });
    }
  }
}
