import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/core/theme/colors.dart';
import 'package:news_app_am/core/theme/text_style.dart';
import 'package:news_app_am/features/home/presentation/logic/home_cubit.dart';
import 'package:news_app_am/features/home/presentation/logic/home_state.dart';

// ignore: must_be_immutable
class NewsCategoriesWidget extends StatelessWidget {
  NewsCategoriesWidget({super.key});
  static List<String> categories = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(buildWhen: (previous, current) {
      return current is ChangeCategoryState;
    }, builder: (BuildContext context, HomeState state) {
      return SizedBox(
        height: 45,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  cubit.currentCategoryIndex = index;
                  cubit.searchNews(categories[index]);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsManager.primaryColor),
                    color: cubit.currentCategoryIndex == index
                        ? ColorsManager.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyleManager.extraLight14,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
