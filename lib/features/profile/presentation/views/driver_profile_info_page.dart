import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';

class DriverProfileInfoPage extends StatelessWidget {
  final DriverProfileModel driver;

  const DriverProfileInfoPage({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('personalInformation'.tr(context)),
      ),
      body: ListView(
        children: [
          _ProfileSection(
            icon: Icons.person_outline,
            label: 'Personal',
            color: const Color(0xFF534AB7),
            bgColor: const Color(0xFFEEEDFE),
            dotColor: const Color(0xFFAFA9EC),
            items: [
              _InfoItem(label: 'full_name'.tr(context), value: driver.fullName),
              _InfoItem(label: 'email'.tr(context), value: driver.email),
              _InfoItem(label: 'phone'.tr(context), value: driver.phone),
              _InfoItem(
                label: 'dateOfBirth'.tr(context),
                value: driver.birthDay,
              ),
            ],
          ),
          _ProfileSection(
            icon: Icons.directions_car_outlined,
            label: 'vehicle'.tr(context),
            color: const Color(0xFF0F6E56),
            bgColor: const Color(0xFFE1F5EE),
            dotColor: const Color(0xFF5DCAA5),
            items: [
              _InfoItem(
                label: 'vechileNumber'.tr(context),
                value: driver.vehicleNumber,
              ),
              _InfoItem(
                label: 'vechileType'.tr(context),
                value: VehicleType.getTitle(driver.vehicleType).tr(context),
              ),
              _InfoItem(
                label: 'experience'.tr(context),
                value:
                    '${driver.drivingExperienceYears} ${'years'.tr(context)}',
              ),
            ],
          ),
          _ProfileSection(
            icon: Icons.bar_chart_outlined,
            label: 'stats'.tr(context),
            color: const Color(0xFF854F0B),
            bgColor: const Color(0xFFFAEEDA),
            dotColor: const Color(0xFFEF9F27),
            items: [
              _InfoItem(
                label: 'totalTrips'.tr(context),
                value: driver.tripsCount.toString(),
              ),
              _InfoItem(
                label: 'rating'.tr(context),
                value: driver.rate.toStringAsFixed(1),
                trailing: _StarRating(rate: driver.rate),
              ),
              _InfoItem(
                label: 'status'.tr(context),
                value: '',
                trailing: _StatusBadge(status: driver.status),
              ),
            ],
          ),
          _AboutSection(description: driver.description),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final Color dotColor;
  final List<_InfoItem> items;

  const _ProfileSection({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.dotColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 14, color: color),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          ...items.map(
            (item) => _InfoRow(
              item: item,
              dotColor: dotColor,
              isLast: items.last == item,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final _InfoItem item;
  final Color dotColor;
  final bool isLast;

  const _InfoRow({
    required this.item,
    required this.dotColor,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const Spacer(),
              item.trailing ??
                  Text(
                    item.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: Theme.of(context).dividerColor,
          ),
      ],
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  final Widget? trailing;

  const _InfoItem({required this.label, required this.value, this.trailing});
}

class _StarRating extends StatelessWidget {
  final double rate;

  const _StarRating({required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (i) {
            return Icon(
              i < rate.floor() ? Icons.star : Icons.star_border,
              size: 14,
              color: const Color(0xFF7F77DD),
            );
          }),
        ),
        const SizedBox(width: 4),
        Text(
          rate.toStringAsFixed(1),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isOnline = status.toLowerCase() == 'online';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: isOnline ? const Color(0xFFEAF3DE) : const Color(0xFFF1EFE8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.tr(context),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isOnline ? const Color(0xFF3B6D11) : const Color(0xFF5F5E5A),
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String description;

  const _AboutSection({required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'about'.tr(context),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'description'.tr(context),
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(
                            context,
                          ).textTheme.bodySmall?.color?.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
