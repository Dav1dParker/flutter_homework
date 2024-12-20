import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  int amount = 0;

  @observable
  int row = 0;

  @observable
  int seat = 0;

  @action
  void updateAmount(int newAmount) {
    amount = newAmount;
  }

  @action
  void updateSeat(int newRow, int newSeat) {
    row = newRow;
    seat = newSeat;
  }
}




