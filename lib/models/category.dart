class Category {
  final int id;
  final String name;
  final String slug;
  final String description;

  const Category(
      {required this.id,
      required this.name,
      required this.slug,
      required this.description});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        slug = json['slug'],
        description = json['description'];

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'slug': slug,
  //       'description': description,
  //     };
}