import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/get_file_from_device.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class CertificateUploadButton extends StatelessWidget {
  const CertificateUploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            final file = await getFileFromDevice();
            if (file != null) {
              cubit.updateFile(file);
            }
          },
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.gray.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.upload_file,
                      color: AppColors.primaryColor,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      cubit.file != null
                          ? cubit.file!.name
                          : "uplodCv".tr(context),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: context.isDarkMode
                            ? AppColors.whiteColor70
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),

                cubit.file != null
                    ? Image.asset(
                        Assets.assetsImagesAccept,
                        width: 22,
                        height: 22,
                      )
                    : Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Colors.grey,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
