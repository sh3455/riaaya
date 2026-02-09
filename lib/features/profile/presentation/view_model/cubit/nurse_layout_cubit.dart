import 'package:flutter_bloc/flutter_bloc.dart';

class NurseLayoutCubit extends Cubit<int> {
  NurseLayoutCubit() : super(0); // 0 = Requests

  void changeTab(int index) {
    emit(index);
  }
}
