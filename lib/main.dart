import 'package:flutter/material.dart';
import 'package:mask_api_mvvm/ui/view/main_page.dart';
import 'package:mask_api_mvvm/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

void main() {
  // notifyListeners가 호출되면 통지를 받아서 StoreModel 객체를 MyApp에 제공
  runApp(ChangeNotifierProvider.value(
      value: StoreModel(),
      child: const MyApp(),
    )
  );
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
      home: MainPage(),
    );
  }
}


