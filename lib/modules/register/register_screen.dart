import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqy/layout/shop_layout.dart';
import 'package:souqy/modules/login/cubit/cubit.dart';
import 'package:souqy/modules/login/cubit/states.dart';
import 'package:souqy/modules/login/login_screen.dart';
import 'package:souqy/modules/register/cubit/cubit.dart';
import 'package:souqy/modules/register/cubit/states.dart';
import 'package:souqy/shared/components/components.dart';
import 'package:souqy/shared/components/constants.dart';
import 'package:souqy/shared/network/local/cache_helper.dart';
import 'package:souqy/shared/styles/colors.dart';

class ShopRegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.data!.token);

              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                TOKEN = state.loginModel.data!.token!;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              CherryToast.error(
                title: Text(state.loginModel.message!),
                toastPosition: Position.bottom,
                animationType: AnimationType.fromLeft,
                toastDuration: const Duration(seconds: 5),
                animationDuration: const Duration(milliseconds: 500),
                autoDismiss: true,
              ).show(context);

            }
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Username',
                          prefix: Icons.person_outline,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email address must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          suffix: cubit.suffix,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (BuildContext context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                            isUpperCase: true,
                            radius: 3.0,
                            background: PrimaryColor,
                          ),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const Text(
                        //       'Already have an account?',
                        //     ),
                        //     TextButton(
                        //       onPressed: () {
                        //         Navigator.pop(context);
                        //       },
                        //       child: const Text(
                        //         'login now',
                        //         style: TextStyle(
                        //           // color: PrimaryColor,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
