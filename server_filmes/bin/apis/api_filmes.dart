import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:postgres/postgres.dart';
import 'database/conexao.dart';

Future<Response> gravarFilmes(Request request) async {
  String corpoRequisicao = await request.readAsString();
  Map dados = jsonDecode(corpoRequisicao);
  try {
    PostgreSQLConnection _conexaoPostgreSQL = await getConexao();
    await _conexaoPostgreSQL.transaction((ctx) async {
      if (dados['id'] != null && dados['id'] > 0) {
        await ctx.query(
            "update filme set nome = @nome, autor = @autor, tipo = @tipo, tempo = @tempo, resumo = @resumo, idiomaLegenda = @idiomaLegenda, idioma = @idioma where id = @id",
            substitutionValues: {
              "nome": dados['nome'],
              'autor': dados['autor'],
              'tipo': dados['tipo'],
              'tempo': dados['tempo'],
              'resumo': dados['resumo'],
              'idiomaLegenda': dados['idiomaLegenda'],
              'idioma': dados['idioma'],
              'id': dados['id']
            });
      } else {
        PostgreSQLResult result = await ctx.query(
            "insert into filme (nome, autor, tipo, tempo, resumo, idioma, idiomaLegenda) values (@nome, @autor, @tipo, @tempo, @resumo, @idioma, @idiomaLegenda) returning id",
            substitutionValues: {
              "nome": dados['nome'],
              'autor': dados['autor'],
              'tipo': dados['tipo'],
              'tempo': dados['tempo'],
              'resumo': dados['resumo'],
              'idioma': dados['idioma'],
              'idiomaLegenda': dados['idiomaLegenda']
            });
        dados['id'] = result.first[0];
      }
    });
    return Response.ok(jsonEncode({'id': dados['id']}));
  } catch (erro) {
    return Response.internalServerError(body: 'ERRO: $erro');
  }
}

Future<Response> deletarFilmes(Request request) async {
  String corpoRequisicao = await request.readAsString();
  Map dados = jsonDecode(corpoRequisicao);
  try {
    PostgreSQLConnection _conexaoPostgreSQL = await getConexao();
    await _conexaoPostgreSQL.transaction((ctx) async {
      await ctx.query("delete from filme where id = @id",
          substitutionValues: {'id': dados['id']});
    });
    return Response.ok(jsonEncode({'id': dados['id']}));
  } catch (erro) {
    return Response.internalServerError(body: 'ERRO: $erro');
  }
}

Future<Response> pesquisarFilmes(Request request) async {
  String corpoRequisicao = await request.readAsString();
  Map dados = jsonDecode(corpoRequisicao);
  try {
    PostgreSQLConnection _conexaoPostgreSQL = await getConexao();
    List<Map<String, Map<String, dynamic>>> results = await _conexaoPostgreSQL
        .mappedResultsQuery("select * from filme where nome ilike @filtro",
            substitutionValues: {'filtro': "%${dados['filtro']}%"});

    List dadosConsulta = [];
    for (var linhaDados in results) {
      dadosConsulta.add({
        "id": linhaDados['filme']?['id'],
        "nome": linhaDados['filme']?['nome'],
        "autor": linhaDados['filme']?['autor'],
        "tipo": linhaDados['filme']?['tipo'],
        "tempo": linhaDados['filme']?['tempo'],
        "resumo": linhaDados['filme']?['resumo'],
        "idioma": linhaDados['filme']?['idioma'],
        "idiomalegenda": linhaDados['filme']?['idiomalegenda']
      });
    }

    return Response.ok(jsonEncode(dadosConsulta));
  } catch (erro) {
    return Response.internalServerError(body: 'ERRO: $erro');
  }
}
