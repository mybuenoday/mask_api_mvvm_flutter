import 'package:flutter/foundation.dart';
import '../model/store.dart';
import '../repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  var isLoading = false;

  // fetch를 하면 return되는 data를 저장하는 list
  List<Store> stores = [];
  final _storeRepository = StoreRepository();

  // StoreModel을 생성할 때 데이터 가져오기
  StoreModel(){
    fetch();
  }

  // view 쪽에서 StoreModel을 통해 fetch를 repository에 의뢰
  Future fetch() async {
    isLoading = true;
    notifyListeners();

    stores = await _storeRepository.fetch();
    isLoading = false;
    // fetch 끝나면 위젯 트리의 맨 꼭대기인 main에 통지하기 위해 Listener 호출
    notifyListeners();
  }
}