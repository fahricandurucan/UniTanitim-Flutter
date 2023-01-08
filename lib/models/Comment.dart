class Comment{
  String comment;
  String title;
  String date;
  int likes;
  String placeId;
  String commentId;
  bool isLiked;  // İMPORTANT!! that propert is not included in firebase.. ist't about to shared preferences

  Comment({required this.comment,required this.title,required this.date,
    required this.likes,required this.placeId, required this.commentId, required this.isLiked});

  Map<String, dynamic> toMap() {
    return {
      'comment': this.comment,
      'title': this.title,
      'date': this.date,
      'likes': this.likes,
      'placeId': this.placeId,
      'commentId': this.commentId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map, bool isLiked) {
    return Comment(
      comment: map['comment'] as String,
      title: map['title'] as String,

      date: map['date'] as String,
      likes: map['likes'] as int,
      placeId: map['placeId'] as String,
      commentId: map['commentId'] as String,
      isLiked: isLiked,
    );
  }
}