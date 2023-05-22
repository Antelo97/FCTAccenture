import 'package:flutter/material.dart';
import 'package:harry_potter_app/data/network/api/BookService.dart';
import 'package:harry_potter_app/data/network/model_response/BookResponse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<BookResponse>? _booksReponse = [];

  void _getData() async {
    _booksReponse = (await BookService().getBooks())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Calls')),
      body: Column(children: [
        if (_booksReponse != null && _booksReponse!.isNotEmpty)
          Text(_booksReponse![0].title)
      ]),
    );
  }
}
