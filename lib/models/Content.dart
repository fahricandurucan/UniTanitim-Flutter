class Content{
  String? title;
  String content;
  String? image;

  Content({this.title, required this.content,this.image});

  Map<dynamic, dynamic> toMap() {
    return {
      'title': this.title,
      'content': this.content,
      'image': this.image,
    };
  }

  factory Content.fromMap(Map<dynamic, dynamic> map) {
    return Content(
      title: map['title'],
      content: map['content'],
      image: map['image'],
    );
  }
}