import 'package:flutter/foundation.dart';
import 'dart:typed_data';

class DataNotifier with ChangeNotifier {
  List _rooms = [];
  List _houses = [];

  var _houseFilter = {'island': 'none'};
  var _roomFilter = {'sort': 'best'};
  String _sort = 'best';
  get rooms => _rooms;
  get houses => _houses;
  get sort => _sort;
  get houseFilter => _houseFilter;
  get roomFilter => _roomFilter;

  void updateRooms(List rooms) {
    _rooms = rooms;
    notifyListeners();
  }

  void updateHouses(List houses) {
    _houses = houses;
    notifyListeners();
  }

  void updateHouseFilter(var filter) {
    _houseFilter = filter;
    notifyListeners();
  }

  void updateRoomFilter(var filter) {
    _roomFilter = filter;
    notifyListeners();
  }

  void updateSort(String sort) {
    _sort = sort;
    notifyListeners();
  }
}
