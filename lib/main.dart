import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stores = <Store>[];

  Future fetch() async {
    // FormatException 오류 -> URI 생성 부분 수정
    // Uri.https 생성자를 사용할 때는 첫 번째 인자로 도메인 이름을, 두 번째 인자로 경로를 전달
    var url = Uri.https('gist.githubusercontent.com', '/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');
    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

    setState(() {
      // 쌓인 리스트 새로고침 위한 clear
      stores.clear();
      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });
    });

  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 구매 가능한 곳: 0곳'),),
      body: ListView(
        children: stores.map((e) {
          return ListTile(
            title: Text(e.name ?? ''),
            subtitle: Text(e.addr ?? ''),
            trailing: Text(e.remainStat ?? '매진'),
          );
        }).toList(),
      ),
    );
  }
}
