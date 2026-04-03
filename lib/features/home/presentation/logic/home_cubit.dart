import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/core/network/remote/api_endpoint.dart';
import 'package:news_app_am/core/network/remote/dio_helper.dart';
import 'package:news_app_am/features/home/data/models/everything_model.dart';
import 'package:news_app_am/features/home/presentation/logic/home_state.dart';
import 'package:news_app_am/features/home/presentation/widgets/news_categories_widget.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  TextEditingController? searchController = TextEditingController();
  EverythingModel? everythingModel;
  int currentCategoryIndex = -1;

  void getNews() async {
    emit(SearchLoadingState());

    final result = await DioHelper.get(
      path: everythingEndpoint,
    );
    result.fold(ifLeft: (error) {
      debugPrint(error);
      emit(SearchErrorState(error));
    }, ifRight: (response) {
      everythingModel = EverythingModel.fromjson(response);
      debugPrint(everythingModel?.status);
      debugPrint(everythingModel?.totalResults.toString());
      debugPrint(everythingModel?.articles?.length.toString());
      emit(SearchSuccessState());
    });
  }

//   try {
//     Response response = await DioHelper.get(path: everythingEndpoint,
//     search: 'bitcoin',
//     queryParameters: {
//       'searchIn': 'title,content',
//     });
// EverythingModel everythingModel=EverythingModel.fromjson(response.data);
//     debugPrint(everythingModel.status);
//         debugPrint(everythingModel.totalResults.toString());
//     debugPrint(everythingModel.articles?.length.toString());
//  } catch (e) {
//    debugPrint('Error$e');
//  }

  void searchNews(String? text) async {
    everythingModel = null;
    emit(SearchLoadingState());

    final result = await DioHelper.searchNews(
      text: text,
      path: everythingEndpoint,
      queryParameters: {
        'searchIn': 'title,content',
      },
    );
    result.fold(ifLeft: (error) {
      debugPrint(error);
      emit(SearchErrorState(error));
    }, ifRight: (response) {
      everythingModel = EverythingModel.fromjson(response);
      debugPrint(everythingModel!.status);
      debugPrint(everythingModel!.totalResults.toString());
      debugPrint(everythingModel!.articles?.length.toString());
      emit(SearchSuccessState());
    });
  }

  void clearSearch() {
    searchController?.clear();
    List<String> categories = NewsCategoriesWidget.categories;
    searchNews(categories[currentCategoryIndex]);
    currentCategoryIndex = currentCategoryIndex;
    emit(ClearSearchState());
  }
}
