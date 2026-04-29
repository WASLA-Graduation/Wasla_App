import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';

class SocialReportView extends StatelessWidget {
  const SocialReportView({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('report'.tr(context))),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.marginDefault,
          vertical: AppSizes.paddingSizeDefault,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,

          child: BlocConsumer<SocialMediaCubit, SocialMediaState>(
            buildWhen: (previous, current) => current is SocialMediaInitial,
            listener: (context, state) {
              if (state is SocialReportSucessState) {
                showToast(
                  'reportSuccess'.tr(context),
                  color: AppColors.acceptGreen,
                );
                Navigator.pop(context);
              } else if (state is SocialReportFailureState) {
                toastAlert(color: AppColors.error, msg: state.errorMessage);
              }
            },
            builder: (context, state) {
              return ReportTextField(data: data);
            },
          ),
        ),
      ),
    );
  }
}

class ReportTextField extends StatefulWidget {
  const ReportTextField({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<ReportTextField> createState() => _UpdateTextFieldState();
}

class _UpdateTextFieldState extends State<ReportTextField> {
  String report = '';
  final formKey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return Form(
      key: formKey,
      child: TextFormField(
        
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: (value) => validateSimpleData(value, context),
        minLines: 1,
        onChanged: (value) {
          setState(() {});
          report = value;
        },
        decoration: InputDecoration(
          hintText:'report'.tr(context) ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                cubit.reportForSomething(
                  reason: report,
                  targetId: widget.data[AppStrings.targetId],
                  targetType: widget.data[AppStrings.targetType],
                );
                FocusScope.of(context).unfocus();
              }
            },
            icon: Image.asset(
              report.trim().isEmpty
                  ? Assets.assetsImagesSendOutlined
                  : Assets.assetsImagesSendFilled,
              width: 25,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
