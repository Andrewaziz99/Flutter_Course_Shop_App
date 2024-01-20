import 'package:souqy/models/change_favorite_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeonboardState extends ShopStates {}

class ShopChangeBottomNavBarState extends ShopStates {}

class ShopChangeModeState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavouritesState extends ShopStates {}

class ShopSuccessChangeFavouritesState extends ShopStates {
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorChangeFavouritesState extends ShopStates {}

class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}


