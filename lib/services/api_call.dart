
import '../models/category.dart';
import '../models/chapter.dart';
import '../models/story.dart';
import 'networking.dart';

const openLiteNovelURL = 'https://truyen-clone.getdata.one/';

class APICall {
  Future<List<dynamic>> getCategories() async {
    NetworkHelper networkHelper = NetworkHelper('${openLiteNovelURL}category');
    List jsonResponse = await networkHelper.getData();
    return jsonResponse.map((index) => Category.fromJson(index)).toList();
  }

  Future<List<dynamic>> getStoryByCategory(int id) async {
    NetworkHelper networkHelper = NetworkHelper('${openLiteNovelURL}category/id/$id/story?page=0&limit=30');
    List jsonResponse = await networkHelper.getData();
    return jsonResponse.map((index) => Story.fromJson(index)).toList();
  }

  Future<List<dynamic>> getChapterByStory(String slug) async {
    NetworkHelper networkHelper = NetworkHelper('${openLiteNovelURL}story/$slug/chapters');
    List jsonResponse = await networkHelper.getData();
    return jsonResponse.map((index) => Chapter.fromJson(index)).toList();
  }

  Future<dynamic> getDetailChapter(int idChapter) async {
    NetworkHelper networkHelper = NetworkHelper('${openLiteNovelURL}chapter/id/$idChapter');
    var jsonResponse = await networkHelper.getData();
    // return jsonResponse.map((index) => Chapter.fromJson(index));
    return Chapter.fromJson(jsonResponse);
  }
}