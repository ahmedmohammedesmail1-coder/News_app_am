import 'package:news_app_am/features/home/data/models/articals_model.dart';

class EverythingModel {
  final String? status;
  final int? totalResults;
  final List<ArticalesModel>? articles;
  EverythingModel({this.status, this.totalResults, this.articles});

  factory EverythingModel.fromjson(Map<String, dynamic> json) {
    return EverythingModel(
      status: json['status'] as String?,
      totalResults: json['totalResults'] as int?,
      articles: json['articles']!=null?(json['articles'] as List<dynamic>?)
          ?.map((articles) =>
              ArticalesModel.fromjson(articles as Map<String, dynamic>))
          .toList():null,
    );
  }
}