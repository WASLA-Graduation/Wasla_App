import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/chat/data/models/chat_user_info.dart';

class ChatUserProfileBody extends StatelessWidget {
  const ChatUserProfileBody({super.key, required this.user});

  final ChatUserInfo user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: user.profileImage.isNotEmpty
                          ? NetworkImage(user.profileImage)
                          : null,
                      backgroundColor: AppColors.gray,
                      child: user.profileImage.isEmpty
                          ? Text(
                              user.name
                                  .trim()
                                  .split(' ')
                                  .take(2)
                                  .map((e) => e[0].toUpperCase())
                                  .join(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: user.isOnline ? Colors.green : Colors.grey,
                          border: Border.all(
                            color: colorScheme.surfaceContainerLow,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  user.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    user.isOnline
                        ? 'Online'.tr(context)
                        : 'Offline'.tr(context),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                _ProfileRow(
                  label: 'phone'.tr(context),
                  value: user.phone,
                  isBold: true,
                ),
                const Divider(height: 1),
                _ProfileRow(
                  label: 'lastSeenAt'.tr(context),
                  value: formatDateToCustomString(user.lastSeen),
                ),
                const Divider(height: 1),
                _ProfileRow(
                  label: 'bio'.tr(context),
                  value: user.bio ?? '',
                  isPlaceholder: user.bio == null,
                  placeholderText: 'noBio'.tr(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isPlaceholder = false,
    this.placeholderText,
  });

  final String label;
  final String value;
  final bool isBold;
  final bool isPlaceholder;
  final String? placeholderText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          isPlaceholder
              ? Text(
                  placeholderText ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                    fontStyle: FontStyle.italic,
                  ),
                )
              : Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
                    color: colorScheme.onSurface,
                  ),
                ),
        ],
      ),
    );
  }
}
