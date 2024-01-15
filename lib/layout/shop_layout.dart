import 'package:flutter/material.dart';
import 'package:souqy/modules/login/login_screen.dart';
import 'package:souqy/shared/components/components.dart';
import 'package:souqy/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Layout'),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token').then((value) {
            if (value) {
              navigateAndFinish(context, ShopLoginScreen());
            }
          });
        },
        child: const Text('Logout')
      ),);
  }
}
