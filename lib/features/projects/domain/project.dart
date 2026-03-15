class Project {
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubUrl,
    required this.liveDemoUrl,
    required this.heroImage,
  });

  final String id;
  final String title;
  final String description;
  final List<String> techStack;
  final String githubUrl;
  final String? liveDemoUrl;
  final String? heroImage;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      techStack: (json['techStack'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      githubUrl: json['githubUrl'] as String,
      liveDemoUrl: json['liveDemoUrl'] as String?,
      heroImage: json['heroImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'techStack': techStack,
      'githubUrl': githubUrl,
      'liveDemoUrl': liveDemoUrl,
      'heroImage': heroImage,
    };
  }
}

