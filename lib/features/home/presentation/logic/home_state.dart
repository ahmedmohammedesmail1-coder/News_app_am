abstract class HomeState {}

class InitialState extends HomeState {}

class SearchLoadingState extends HomeState {}

class SearchSuccessState extends HomeState {}

class SearchErrorState extends HomeState {
  final String error;

  SearchErrorState(this.error);
}

class ChangeCategoryState extends HomeState {}

class ClearSearchState extends HomeState {}
