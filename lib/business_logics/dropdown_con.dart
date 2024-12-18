import 'package:get/get.dart';

class DropdownController extends GetxController {
  // RxInt is reactive, allowing automatic UI updates when it changes.
  var selectedIndex = (-1).obs;

  // Function to update the selected index
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
