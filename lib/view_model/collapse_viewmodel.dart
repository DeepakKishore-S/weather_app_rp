import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollapseViewModel extends StateNotifier<bool> {
  CollapseViewModel() : super(false);

  void toggleCollapse(bool isCollapsed) {
    state = isCollapsed;
  }
}