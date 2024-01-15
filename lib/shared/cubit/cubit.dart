import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqy/shared/cubit/states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(AppInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeonboardingindex(int index) {
    currentIndex = index;
    emit(ShopChangeonboardState());
  }

}