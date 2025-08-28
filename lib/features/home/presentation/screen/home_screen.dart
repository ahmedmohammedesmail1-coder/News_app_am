import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/core/theme/colors.dart';
import 'package:news_app_am/core/theme/text_style.dart';
import 'package:news_app_am/core/util/constans/spacing.dart';
import 'package:news_app_am/features/home/presentation/logic/home_cubit.dart';
import 'package:news_app_am/features/home/presentation/logic/home_state.dart';
import 'package:news_app_am/features/home/presentation/widgets/news_categories_widget.dart';
import 'package:news_app_am/features/home/presentation/widgets/search_list_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Timer? debounce;
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsManager.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    Text('Search Your Daily News',
                        style: TextStyleManager.extraLight18),
                    Spacer(),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/images/20221225_140021.jpg'),
                    ),
                  ],
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: TextFormField(
                      controller: homeCubit.searchController,
                      onChanged: (String text) {
                        if (text.characters.length > 3) {
                          if (debounce?.isActive ?? false) debounce?.cancel();
                          debounce = Timer(const Duration(seconds: 3), () {
                            homeCubit.searchNews(text);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: homeCubit.searchController!.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.close),
                                color: ColorsManager.textColorGrey,
                                onPressed: () {
                                  homeCubit.clearSearch();
                                },
                              )
                            : null,
                        filled: false,
                        fillColor: ColorsManager.scaffoldBackgroundColor,
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorsManager.textColorGrey,
                        ),
                        hintText: 'Search for news...',
                        hintStyle: TextStyleManager.light14
                            .copyWith(color: ColorsManager.textColorGrey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: ColorsManager.textColorGrey),
                        ),
                      ),
                    ),
                  );
                },
              ),
              NewsCategoriesWidget(),
              verticalSpace(16),
              ListViewSearchNews(),
            ],
          ),
        ),
      ),
    );
  }
}
