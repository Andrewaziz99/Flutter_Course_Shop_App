import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqy/models/favorite_model.dart';
import 'package:souqy/shared/components/components.dart';
import 'package:souqy/shared/cubit/cubit.dart';
import 'package:souqy/shared/cubit/states.dart';
import 'package:souqy/shared/styles/colors.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavouritesState,
            builder: (BuildContext context) => ListView.separated(
              itemBuilder: (context, index) => buildFavItem(
                  ShopCubit.get(context).favoriteModel!.data!.data![index],
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).favoriteModel!.data!.data!.length,
            ),
            fallback: (BuildContext context) => const Center(
              child: CircularProgressIndicator(),
            )
          );
        });
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      '${model.product?.image}',
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.product?.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.red,
                      child: Text(
                        '${model.product?.discount} % OFF',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product?.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product?.price.round()}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            height: 1.3,
                            color: DefaultColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.product?.discount != 0)
                          Text(
                            '${model.product?.oldPrice.round()}',
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavourites(model.product!.id!);
                          },
                          icon: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: ShopCubit.get(context)
                                    .favourites[model.product!.id]!
                                ? DefaultColor
                                : Colors.grey[300],
                            child: const Icon(
                              Icons.favorite_border,
                              size: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
