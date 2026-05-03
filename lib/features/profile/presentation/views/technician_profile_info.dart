import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class TechnicianProfileInfo extends StatelessWidget {
  const TechnicianProfileInfo({super.key, required this.technician});

  final TechnicianModel technician;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.darkbackgroundColor
          : AppColors.lightbackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _TechnicianProfileHeader(technician: technician),
            _TechnicianInfoSection(technician: technician),
            _TechnicianDescriptionSection(description: technician.description),
          ],
        ),
      ),
    );
  }
}

class _TechnicianProfileHeader extends StatelessWidget {
  const _TechnicianProfileHeader({required this.technician});

  final TechnicianModel technician;

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = SizeConfig.isTablet ? 50.0 : 36.0;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: SizeConfig.isTablet ? 220.0 : 180.0,
          width: double.infinity,
          color: AppColors.primaryColor,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16,
            left: 24,
            right: 24,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'profile'.tr(context),
              style: AppStyles.styleBold25(
                context,
              ).copyWith(color: AppColors.whiteColor),
            ),
          ),
        ),
        Positioned(
          bottom: -avatarRadius * 0.5,
          child: Stack(
            children: [
              CircleNeworkImage(
                imageUrl: technician.imageUrlBase,
                isLoading: false,
                size: avatarRadius * 3,
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: technician.isAvailable
                        ? Colors.green
                        : AppColors.gray,
                    border: Border.all(color: AppColors.whiteColor, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TechnicianInfoSection extends StatelessWidget {
  const _TechnicianInfoSection({required this.technician});

  final TechnicianModel technician;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final double avatarRadius = SizeConfig.isTablet ? 50.0 : 36.0;
    final double spacing = SizeConfig.isTablet ? 20.0 : 14.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        SizeConfig.isTablet ? 32 : 20,
        avatarRadius * 0.6 + 12,
        SizeConfig.isTablet ? 32 : 20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            technician.fullName,
            textAlign: TextAlign.center,
            style: AppStyles.styleBold25(context).copyWith(
              color: isDark ? AppColors.whiteColor : AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 6),
          _StarRating(rate: technician.rate.toInt()),
          SizedBox(height: spacing),
          Divider(
            color: isDark
                ? AppColors.whiteColor.withOpacity(0.1)
                : AppColors.blackColor.withOpacity(0.08),
          ),
          SizedBox(height: spacing),
          _InfoGrid(technician: technician),
          SizedBox(height: spacing),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.rate});

  final int rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < rate ? Icons.star_rounded : Icons.star_outline_rounded,
          color: Colors.amber,
          size: SizeConfig.isTablet ? 28 : 22,
        );
      }),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.technician});

  final TechnicianModel technician;

  @override
  Widget build(BuildContext context) {
    final items = [
      _InfoItem(
        icon: Icons.phone_rounded,
        label: 'phone'.tr(context),
        value: technician.phone,
      ),
      _InfoItem(
        icon: Icons.email_rounded,
        label: 'email'.tr(context),
        value: technician.email,
      ),
      _InfoItem(
        icon: Icons.work_rounded,
        label: 'experience'.tr(context),
        value: '${technician.experienceYears} ${'years'.tr(context)}',
      ),
      _InfoItem(
        icon: Icons.cake_rounded,
        label: 'birthday'.tr(context),
        value: technician.birthDay,
      ),
    ];

    return GridView.count(
      crossAxisCount: SizeConfig.isTablet ? 3 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: SizeConfig.isTablet ? 2.2 : 1.8,
      children: items.map((item) => _InfoCard(item: item)).toList(),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.item});

  final _InfoItem item;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.whiteColor.withOpacity(0.06)
            : AppColors.primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.whiteColor.withOpacity(0.08)
              : AppColors.primaryColor.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(item.icon, size: 14, color: AppColors.primaryColor),
              const SizedBox(width: 6),
              Text(
                item.label,
                style: AppStyles.smallDesdcriptionStyle.copyWith(
                  fontSize: SizeConfig.isTablet ? 13 : 11,
                  color: isDark
                      ? AppColors.whiteColor.withOpacity(0.5)
                      : AppColors.gray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.styleSemiBold16(context).copyWith(
              fontSize: SizeConfig.isTablet ? 15 : 13,
              color: isDark ? AppColors.whiteColor : AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TechnicianDescriptionSection extends StatelessWidget {
  const _TechnicianDescriptionSection({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final double h = SizeConfig.isTablet ? 20.0 : 14.0;

    if (description.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.isTablet ? 32 : 20,
        vertical: h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'about'.tr(context),
            style: AppStyles.styleSemiBold20(context).copyWith(
              color: isDark ? AppColors.whiteColor : AppColors.blackColor,
            ),
          ),
          SizedBox(height: h / 2),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(SizeConfig.isTablet ? 20 : 14),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.whiteColor.withOpacity(0.06)
                  : AppColors.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? AppColors.whiteColor.withOpacity(0.08)
                    : AppColors.primaryColor.withOpacity(0.10),
              ),
            ),
            child: Text(
              description,
              style: AppStyles.styleMeduim17(context).copyWith(
                color: isDark
                    ? AppColors.whiteColor.withOpacity(0.75)
                    : AppColors.blackColor.withOpacity(0.7),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
