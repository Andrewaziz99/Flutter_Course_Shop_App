import 'package:cherry_toast/cherry_toast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqy/shared/components/components.dart';
import 'package:souqy/shared/cubit/cubit.dart';
import 'package:souqy/shared/cubit/states.dart';
import 'package:souqy/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {
      if (state is ShopSuccessUpdateUserState) {
        if (state.model.status!) {
          CherryToast.success(
            toastDuration: const Duration(seconds: 5),
            title: const Text('Success'),
            enableIconAnimation: true,
            description: Text(state.model.message!),
          ).show(context);
        } else {
          CherryToast.error(
            toastDuration: const Duration(seconds: 5),
            title: const Text('Error'),
            enableIconAnimation: true,
            description: Text(state.model.message!),
          ).show(context);
        }
      }
    }, builder: (BuildContext context, state) {
      var userModel = ShopCubit.get(context).userDataModel;

      nameController.text = userModel!.data!.name!;
      emailController.text = userModel.data!.email!;
      phoneController.text = userModel.data!.phone!;

      return ConditionalBuilder(
        condition: state is! ShopLoadingUserDataState,
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    Image(
                      image: NetworkImage(
                          ShopCubit.get(context).userDataModel!.data!.image!),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Username',
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Username must not be empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icons.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      background: PrimaryColor,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'update',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        fallback: (BuildContext context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
