class Content{
  String? title;
  String content;
  String? image;

  Content({this.title, required this.content, this.image});

  Map<String, String> toMap() {
    return {
      'title': this.title.toString(),
      'content': this.content,
      'image': this.image.toString(),
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] as String,
    );
  }
}