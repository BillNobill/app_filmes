import 'package:brasil_fields/brasil_fields.dart';
import 'package:aplicativo_filmes/data/filmes_dao.dart';
import 'package:aplicativo_filmes/model/filme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FilmesCadastro extends StatefulWidget {
  Function? acaoAposSalvar;
  Filme filmeEmEdicao = Filme();

  FilmesCadastro(this.filmeEmEdicao, {this.acaoAposSalvar});

  @override
  State<FilmesCadastro> createState() => _FilmesCadastroState();
}

class _FilmesCadastroState extends State<FilmesCadastro> {
  GlobalKey<FormState> chaveForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro de Filmes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.save),
          label: const Text('SALVAR'),
          onPressed: () async {
            if (chaveForm.currentState != null &&
                chaveForm.currentState!.validate()) {
              chaveForm.currentState!.save();
              FilmeDAO dao = FilmeDAO();
              bool gravou = await dao.gravar(widget.filmeEmEdicao);
              if (gravou) {
                debugPrint('SALVOU CERTO!');
                if (widget.acaoAposSalvar != null) {
                  widget.acaoAposSalvar!();
                }
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              } else {
                debugPrint('DEU ERRO!');
              }
            }
          }),
      body: ListView(
        children: [
          Form(
            key: chaveForm,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Nome do Filme",
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      icon: Icon(
                        Icons.movie_rounded,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    initialValue: widget.filmeEmEdicao.nome,
                    onSaved: (String? value) {
                      widget.filmeEmEdicao.nome = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o nome do filme!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Autor",
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      icon: Icon(
                        Icons.person_rounded,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    initialValue: widget.filmeEmEdicao.autor,
                    onSaved: (String? value) {
                      widget.filmeEmEdicao.autor = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o autor do filme!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Tipo",
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      icon: Icon(
                        Icons.library_books,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    initialValue: widget.filmeEmEdicao.tipo,
                    onSaved: (String? value) {
                      widget.filmeEmEdicao.tipo = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o tipo do filme!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Duração",
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      icon: Icon(
                        Icons.access_time_filled,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      HoraInputFormatter(),
                    ],
                    initialValue: widget.filmeEmEdicao.tempo,
                    onSaved: (String? value) {
                      widget.filmeEmEdicao.tempo = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe a duração do filme!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Idioma",
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      icon: Icon(
                        Icons.speaker_notes_rounded,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    initialValue: widget.filmeEmEdicao.idioma,
                    onSaved: (String? value) {
                      widget.filmeEmEdicao.idioma = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o idioma do filme!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Idioma da Legenda",
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      icon: Icon(
                        Icons.speaker_notes_rounded,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    initialValue: widget.filmeEmEdicao.idiomaLegenda,
                    onSaved: (String? value) {
                      widget.filmeEmEdicao.idiomaLegenda = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o idioma da legenda do filme!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Resumo",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      suffixText: "500",
                      icon: Icon(
                        Icons.summarize_rounded,
                        color: Color.fromARGB(255, 52, 52, 52),
                      ),
                    ),
                    initialValue: widget.filmeEmEdicao.resumo,
                    onSaved: (String? value) {
                      widget.filmeEmEdicao.resumo = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o resumo do filme!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
