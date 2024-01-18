import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqy/models/categories_model.dart';
import 'package:souqy/models/home_model.dart';
import 'package:souqy/modules/categories/categories_screen.dart';
import 'package:souqy/modules/favourite/favourite_screen.dart';
import 'package:souqy/modules/products/products_screen.dart';
import 'package:souqy/modules/settings/settings_screen.dart';
import 'package:souqy/shared/components/constants.dart';
import 'package:souqy/shared/cubit/states.dart';
import 'package:souqy/shared/network/end_points.dart';
import 'package:souqy/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeonboardingindex(int index) {
    currentIndex = index;
    emit(ShopChangeonboardState());
  }

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: TOKEN,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

CategoriesModel? categoriesModel;

  void getCatData() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

}
