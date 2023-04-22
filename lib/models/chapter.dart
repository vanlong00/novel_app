class Chapter {
  final int id;
  final String header;
  final String slug;
  List<dynamic>? body;

  Chapter({
    required this.id,
    required this.header,
    required this.slug,
    this.body,
  });

  Chapter.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        header = json['header'],
        slug = json['slug'],
        body = json['body'];
}
