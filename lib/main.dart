import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mask_api_mvvm/repository/store_repository.dart';
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
  var stores = <Store>[];
  var isLoading = true;

  final storeRepository = StoreRepository();

  @override
  void initState() {
    super.initState();

    // list stores를 리턴하는 fetch, async 대신에 .then
    storeRepository.fetch().then((value) {
      setState(() {
        stores = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '마스크 구매 가능한 곳: ${stores.where((e) => e.remainStat == 'plenty' || e.remainStat == 'some' || e.remainStat == 'few').length}곳'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              storeRepository.fetch().then((e) {
                (setState(() {
                  stores = e;
                }));
              });
            },
          )
        ],
      ),
      body: isLoading
          ? loadingWidget()
          : ListView(
              children: stores
                  .where((e) =>
                      e.remainStat == 'plenty' ||
                      e.remainStat == 'some' ||
                      e.remainStat == 'few')
                  .map((e) {
                return ListTile(
                  title: Text(e.name ?? ''),
                  subtitle: Text(e.addr ?? ''),
                  trailing: _buildRemainStatWidget(e),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30-99개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2-29개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
    }

    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(description),
      ],
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
