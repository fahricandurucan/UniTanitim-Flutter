class Content{
  String? title;
  String content;
  String? image;

  Content({this.title, required this.content, this.image});

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'content': this.content,
      'image': this.image,
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