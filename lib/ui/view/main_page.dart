import 'package:flutter/material.dart';
import 'package:mask_api_mvvm/ui/widget/remain_stat_list_tile.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/store_model.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '마스크 구매 가능한 곳: ${storeModel.stores.length}곳'),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                storeModel.fetch();
              }
          )
        ],
      ),
      body: storeModel.isLoading == true
          ? loadingWidget()
          : ListView(
        children: storeModel.stores
            .where((e) =>
        e.remainStat == 'plenty' ||
            e.remainStat == 'some' ||
            e.remainStat == 'few')
            .map((e) {
          return ListTile(
            title: Text(e.name ?? ''),
            subtitle: Text(e.addr ?? ''),
            trailing: RemainStatListTile(e),
          );
        }).toList(),
      ),
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