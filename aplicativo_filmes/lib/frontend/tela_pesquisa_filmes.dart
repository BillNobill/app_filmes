import 'package:aplicativo_filmes/data/filmes_dao.dart';
import 'package:aplicativo_filmes/frontend/tela_cadastro_filmes.dart';
import 'package:aplicativo_filmes/model/filme.dart';
import 'package:flutter/material.dart';

class TelaPesquisaFilme extends StatefulWidget {
  const TelaPesquisaFilme({super.key});

  @override
  State<TelaPesquisaFilme> createState() => _TelaPesquisaFilmeState();
}

class _TelaPesquisaFilmeState extends State<TelaPesquisaFilme> {
  FocusNode focusNodeCampoPesquisa = FocusNode();
  TextEditingController controladorCampoFiltro = TextEditingController();
  List<Filme> filmesPesquisados = [];

  Future<List<Filme>> pesquisarFilmes(String filtro) async {
    FilmeDAO dao = FilmeDAO();
    return dao.pesquisar(filtro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
        title: const Text(
          'Lista de Filmes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 60),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                focusNode: focusNodeCampoPesquisa,
                textInputAction: TextInputAction.search,
                onSubmitted: (String texto) {
                  setState(() {
                    pesquisarFilmes(texto);
                  });
                  focusNodeCampoPesquisa.requestFocus();
                },
                controller: controladorCampoFiltro,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Filtro de pesquisa"),
              ),
            ))),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FilmesCadastro(
                  Filme(),
                  acaoAposSalvar: () {
                    setState(
                      () {
                        pesquisarFilmes(controladorCampoFiltro.text);
                      },
                    );
                  },
                ),
              ),
            );
          },
          child: const Icon(Icons.add)),
      body: FutureBuilder(
        future: pesquisarFilmes(controladorCampoFiltro.text),
        builder: (BuildContext context, AsyncSnapshot<List<Filme>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Carregando dados. Aguarde...'),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar dados. Tente novamente.'),
            );
          }
          filmesPesquisados = snapshot.data as List<Filme>;
          return ListView.builder(
            itemCount: filmesPesquisados.length,
            itemBuilder: (context, indice) {
              return ListTile(
                tileColor: indice % 2 == 0
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color.fromARGB(255, 244, 244, 244),
                title: Row(
                  children: [
                    Expanded(child: Text(filmesPesquisados[indice].nome ?? "")),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FilmesCadastro(
                                    filmesPesquisados[indice],
                                    acaoAposSalvar: () {
                                      setState(() {
                                        pesquisarFilmes(
                                            controladorCampoFiltro.text);
                                      });
                                    },
                                  )));
                        },
                        icon: const Icon(Icons.edit,
                            color: Color.fromARGB(255, 255, 207, 50))),
                    IconButton(
                      onPressed: () async {
                        FilmeDAO dao = FilmeDAO();
                        if (await dao.deletar(filmesPesquisados[indice].id)) {
                          setState(() {
                            pesquisarFilmes(controladorCampoFiltro.text);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
