import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';

class GymPackeWithDiscoutnField extends StatelessWidget {
  const GymPackeWithDiscoutnField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();
    return BlocBuilder<GymPackagesCubit, GymPackagesState>(
      builder: (context, state) {
        return Visibility(
          visible: cubit.gymPackagTypeValue == 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomTextFormField(
              // initealValue: model?.price.toString(),
              keyboardTyp: TextInputType.number,
              onChanged: (value) {
                cubit.packagePercentage = value.isEmpty
                    ? 0
                    : double.parse(value);
              },
              validator: (value) => validateSimpleData(value, context),
              withBorder: true,
              fillColor: Colors.transparent,
              withTitle: true,
              title: "discount".tr(context),
            ),
          ),
        );
      },
    );
  }
}
