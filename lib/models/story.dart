class Story {
  final int id;
  final String title;
  final String author;
  final String slug;
  final String poster;
  final String status;
  final String updatedDate;

  Story(
      {required this.id,
      required this.title,
      required this.author,
      required this.slug,
      required this.poster,
      required this.status,
      required this.updatedDate});

  Story.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        slug = json['slug'],
        poster = json['poster'],
        status = json['status'],
        updatedDate = json['updatedDate'];
}
