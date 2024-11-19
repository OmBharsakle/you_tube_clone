

class ApiModel {
  late List<Categories> categories;

  ApiModel({required this.categories});

  factory ApiModel.fromJson(Map m1)
  {
    return ApiModel(categories: (m1['categories'] as List).map((e) => Categories.fromJson(e),).toList());
  }
}

class Categories {
  late String name;
  late List<Videos> videos;

  Categories({required this.name,required this.videos});

  factory Categories.fromJson(Map m1)
  {
    return Categories(name: m1["name"], videos: (m1["videos"] as List).map((e) => Videos.fromJson(e),).toList());
  }
}

class Videos {
  late String description, subtitle, thumb, title;
  late List  sources;
  Videos(
      {required this.description,
      required this.sources,
      required this.subtitle,
      required this.thumb,
      required this.title});

  factory Videos.fromJson(Map m1) {
    return Videos(
        description: m1['description'],
        sources: m1['sources'],
        subtitle: m1['subtitle'],
        thumb: m1['thumb'],
        title: m1['title']);
  }
}
