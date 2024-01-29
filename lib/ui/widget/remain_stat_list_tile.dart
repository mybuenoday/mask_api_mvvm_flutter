import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/store.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;
  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(store.addr ?? ''),
          Text('${store.km}km'),
        ],
      ),
      trailing: _buildRemainStatWidget(store),
      onTap: () {
        _launchUrl(store.lat ?? 0.0, store.lng ?? 0.0);
      },
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

  Future<void> _launchUrl(num lat, num lng) async {
    final Uri _url = Uri.parse('https://google.com/maps/search/?api=1&query=$lat,$lng');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

}
