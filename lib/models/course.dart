class Resource {
  String id;
  String title;
  String url;

  Resource({
    required this.id,
    required this.title,
    required this.url,
  });

  // Convert a JSON map to a Resource object
  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }

  // Convert a Resource object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
    };
  }
}

class Lesson {
  String id;
  String title;
  String description;
  String url;
  List<Resource> resources;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.resources,
  });

  // Convert a JSON map to a Lesson object
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      resources: (json['resources'] as List<dynamic>)
          .map((resourceJson) => Resource.fromJson(resourceJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // Convert a Lesson object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'resources': resources.map((resource) => resource.toJson()).toList(),
    };
  }
}

class Course {
  String id;
  String server;
  String name;
  String prerequisite;
  String description;
  List<Lesson> lessons;

  Course({
    required this.id,
    required this.server,
    required this.name,
    required this.prerequisite,
    required this.description,
    required this.lessons,
  });

  // Convert a JSON map to a Course object
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      server: json['server'] as String,
      name: json['name'] as String,
      prerequisite: json['prerequisite'] as String,
      description: json['description'] as String,
      lessons: (json['lessons'] as List<dynamic>)
          .map((lessonJson) => Lesson.fromJson(lessonJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // Convert a Course object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'server': server,
      'name': name,
      'prerequisite': prerequisite,
      'description': description,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }
}
