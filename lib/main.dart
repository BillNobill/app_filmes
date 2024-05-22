import 'package:aplicativo_filmes/frontend/tela_pesquisa_filmes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromARGB(255, 34, 34, 34),
            onPrimary: Colors.white,
            secondary: Color.fromARGB(255, 34, 34, 34),
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.white,
            onBackground: Color.fromARGB(255, 34, 34, 34),
            surface: Color.fromARGB(255, 255, 255, 255),
            onSurface: Color.fromARGB(255, 34, 34, 34)),
        useMaterial3: true,
      ),
      home: const TelaPesquisaFilme(),
    );
  }
}
