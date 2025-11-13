import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_choose_resturent_image.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class CustomResturentInfo extends StatelessWidget {
  const CustomResturentInfo({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.resturentInfoformKey,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: CustomTextFormField(
              prefixIcon: Icon(Icons.person),
              hint: "ownerName".tr(context),
              onChanged: (owner) {
                cubit.owner = owner;
              },
              validator: (value) => validateName(value, context),
            ),
          ),
          SliverToBoxAdapter(child: VerticalSpace(height: 2)),
          SliverToBoxAdapter(
            child: CustomTextFormField(
              prefixIcon: Icon(Icons.restaurant),
              hint: "resturentName".tr(context),
              onChanged: (resName) {
                cubit.resturentName = resName;
              },
              validator: (value) => validateName(value, context),
            ),
          ),
          SliverToBoxAdapter(child: VerticalSpace(height: 2)),
          SliverToBoxAdapter(
            child: CustomTextFormField(
              readOnly: true,
              onTap: () {
                context.pushScreen(AppRoutes.authMapScreen);
              },
              controller: cubit.addressController,
              prefixIcon: Icon(Icons.location_on),
              hint: "address".tr(context),
              validator: (value) => validateAddress(value, context),
            ),
          ),
          SliverToBoxAdapter(child: VerticalSpace(height: 2)),
          SliverToBoxAdapter(child: CustomChooseResturentImage()),
          SliverToBoxAdapter(child: VerticalSpace(height: 2)),
          SliverToBoxAdapter(
            child: CustomTextFormField(
              hint: "descriptionAboutResturent".tr(context),
              onChanged: (description) => cubit.description = description,
              validator: (value) => validateSimpleData(value, context),
              maxLines: 5,
            ),
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Spacer(),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return GeneralButton(
                      onPressed: () async {
                        if (cubit.resturentInfoformKey.currentState!
                            .validate()) {}
                      },
                      text: state is AuthDoctorCompleteInfoLoading
                          ? "sending".tr(context)
                          : "save".tr(context),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
