import 'package:get/get.dart';

class CommonController extends GetxController {
  ///bottomBar
  int _bottomIndex = 0;

  int get bottomIndex => _bottomIndex;

  set bottomIndex(int value) {
    _bottomIndex = value;
    update();
  }
}
