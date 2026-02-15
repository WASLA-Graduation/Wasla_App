import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/profile/presentation/widgets/gym_profile_top_section.dart';

class GymProfileInfoViweBody extends StatelessWidget {
  const GymProfileInfoViweBody({super.key, required this.gym});
  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GymProfileTopSection(gym: gym),

        const SizedBox(height: 20),
        GeneralDevDescription(description: gym.description),
        const SizedBox(height: 20),
        GeneralRatingWidget(rating: gym.rating),
        const SizedBox(height: 20),
        ContactWidet(contacts: gym.phones),
        const SizedBox(height: 20),
        GymProfileGalary(images: gym.photos),
      ],
    );
  }
}

class GeneralDevDescription extends StatelessWidget {
  const GeneralDevDescription({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'description'.tr(context),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ReadmoreText(maxLines: 3, text: description),
        ],
      ),
    );
  }
}

class ContactWidet extends StatelessWidget {
  const ContactWidet({super.key, required this.contacts});
  final List<String> contacts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'contacts'.tr(context),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ...contacts
              .map(
                (contact) => Row(
                  spacing: 15,
                  children: [
                    Icon(Icons.phone, size: 25, color: AppColors.primaryColor),
                    Text(
                      contact,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class GymProfileGalary extends StatelessWidget {
  const GymProfileGalary({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      height: 150,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: images
            .map(
              (image) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomCachedNetworkImage(
                    imageUrl: image,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class GeneralRatingWidget extends StatelessWidget {
  const GeneralRatingWidget({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'rating'.tr(context),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Row(
            spacing: 10,
            children: [
              Icon(Icons.star, size: 25, color: AppColors.primaryColor),
              Text(
                rating.toString(),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
