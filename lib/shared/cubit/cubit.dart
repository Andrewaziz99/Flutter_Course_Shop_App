import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqy/models/categories_model.dart';
import 'package:souqy/models/change_favorite_model.dart';
import 'package:souqy/models/favorite_model.dart';
import 'package:souqy/models/home_model.dart';
import 'package:souqy/models/login_model.dart';
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

  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: TOKEN,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({element.id!: element.inFavorites!});
      });
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

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavourites(int productId, context) {

    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavouritesState());

    DioHelper.postData(
      url: FAVORITES,
      token: TOKEN,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      }else {
        getFavourites();
      }

      CherryToast.success(
        toastDuration: const Duration(seconds: 3),
        title: const Text('Success'),
        enableIconAnimation: true,
        description: Text(changeFavoriteModel!.message!),
      ).show(context);

      emit(ShopSuccessChangeFavouritesState(changeFavoriteModel!));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      print(error.toString());
      emit(ShopErrorChangeFavouritesState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavourites() {
    emit(ShopLoadingGetFavouritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: TOKEN,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouritesState());
    });
  }

  ShopLoginModel? userDataModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: TOKEN,
    ).then((value) {
      userDataModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  ShopLoginModel? updateUserDataModel;

  void updateUserData({
    String? name,
    String? email,
    String? phone,
    String? image,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: TOKEN,
      data: {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    },
    ).then((value) {
      userDataModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userDataModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}
