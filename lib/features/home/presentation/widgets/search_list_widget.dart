import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/core/theme/colors.dart';
import 'package:news_app_am/core/theme/text_style.dart';
import 'package:news_app_am/core/util/constans/spacing.dart';
import 'package:news_app_am/features/home/data/models/articals_model.dart';
import 'package:news_app_am/features/home/data/models/everything_model.dart';
import 'package:news_app_am/features/home/presentation/logic/home_cubit.dart';
import 'package:news_app_am/features/home/presentation/logic/home_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class ListViewSearchNews extends StatelessWidget {
  ListViewSearchNews({super.key});
  EverythingModel? everythingModel;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is SearchLoadingState ||
            current is SearchSuccessState ||
            current is SearchErrorState;
      },
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return Expanded(child: LoadingSearchListWidget());
        }
        if (state is SearchErrorState) {
          return Column(
            children: [
              verticalSpace(150),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryColor.withValues(alpha: 50),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      state.error,
                      style: TextStyleManager.extraLight16
                          .copyWith(color: Colors.red),
                    )),
              )),
            ],
          );
        }
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              ArticalesModel article =
                  homeCubit.everythingModel!.articles![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            color: ColorsManager.textColor, width: 2),
                        color: ColorsManager.primaryDarkColor,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Image.network(
                            'https://t4.ftcdn.net/jpg/00/89/55/15/360_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg'),
                      ),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title ?? 'No Title',
                            style: TextStyleManager.extraLight16,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                          ),
                          Text(
                            article.description?.trim() ?? 'No Description',
                            style: TextStyleManager.light12.copyWith(
                                color: ColorsManager.primaryColor
                                    .withValues(alpha: 150)),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => verticalSpace(16),
            itemCount: homeCubit.everythingModel?.articles?.length ?? 0,
          ),
        );
      },
    );
  }
}

class LoadingSearchListWidget extends StatelessWidget {
  const LoadingSearchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: ColorsManager.textColorGrey.withValues(alpha: 100),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                horizontalSpace(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'iphone 14 is amazing and I want one and I will buy it as soon as possible',
                        style: TextStyleManager.extraLight16,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                      Text(
                        'The iPhone 14 features a sleek design and powerful performance and I want one and I will buy it as soon as possible and I will buy it as soon as possible and I will buy it as soon as possible',
                        style: TextStyleManager.light12.copyWith(
                            color: ColorsManager.primaryColor
                                .withValues(alpha: 150)),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => verticalSpace(16),
        itemCount: 10,
      ),
    );
  }
}
