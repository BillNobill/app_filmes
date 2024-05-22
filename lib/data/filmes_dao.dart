import 'dart:convert';
import 'package:aplicativo_filmes/model/filme.dart';
import 'package:dio/dio.dart';

class FilmeDAO {
  Future<bool> gravar(Filme filme) async {
    //Chamada ao backend
    Dio dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.extra["withCredentials"] = true;
      return handler.next(options);
    }));

    Response response =
        await dio.post('http://localhost:8080/filmes/gravar', data: {
      "id": filme.id,
      "nome": filme.nome,
      "autor": filme.autor,
      "tipo": filme.tipo,
      "tempo": filme.tempo,
      "resumo": filme.resumo,
      "idioma": filme.idioma,
      "idiomalegenda": filme.idiomaLegenda
    });

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.data);
      filme.id = responseMap['id'];
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletar(int id) async {
    //Chamada ao backend
    Dio dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.extra["withCredentials"] = true;
      return handler.next(options);
    }));

    Response response = await dio
        .post('http://localhost:8080/filmes/deletar', data: {"id": id});

    return response.statusCode == 200;
  }

  Future<List<Filme>> pesquisar(String filtro) async {
    List<Filme> filmes = [];
    //Chamada ao backend
    Dio dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.extra["withCredentials"] = true;
      return handler.next(options);
    }));

    Response response = await dio.post('http://localhost:8080/filmes/pesquisar',
        data: {"filtro": filtro});

    if (response.statusCode == 200) {
      List responseMapList = jsonDecode(response.data);
      for (var dados in responseMapList) {
        Filme filme = Filme();
        filme.id = dados['id'];
        filme.nome = dados['nome'];
        filme.autor = dados['autor'];
        filme.tipo = dados['tipo'];
        filme.tempo = dados['tempo'];
        filme.resumo = dados['resumo'];
        filme.idioma = dados['idioma'];
        filme.idiomaLegenda = dados['idiomalegenda'];
        filmes.add(filme);
      }
    }

    return filmes;
  }
}
