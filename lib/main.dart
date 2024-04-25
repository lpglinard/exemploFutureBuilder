import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<http.Response> _fetchData;

  Future<http.Response> fetchACat() async {
    var resposta = await http.get(Uri.parse("https://cataas.com/cat"));
    print(resposta.statusCode);
    return resposta;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData = http.get(Uri.parse("https://cataas.com/cat"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<http.Response>(
          future: _fetchData,
          builder: (context, AsyncSnapshot<http.Response> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return Center(child: Image.memory(snapshot.data!.bodyBytes));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Vai buscar um gato");
            fetchACat();
            print("Buscou um gato");
          },
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
