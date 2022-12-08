class Comment{
  late String comment;
  late String title;
  late String date;
  late int likes;
  late String placeId;

  Comment({required this.comment,required this.title,required this.date,
    required this.likes,required this.placeId});

  Map<String,dynamic> toMap(){
    return{
      "comment": this.comment,
       "title": this.title,
      "date": this.date,
      "likes": this.likes,
      "placeId": this.placeId,
    };
  }

  factory Comment.fromMap(Map<String,dynamic> map){
    return Comment(
        comment:  map["comment"],
        title: map["title"],
        date: map["date"],
        likes: map["likes"],
        placeId: map["placeId"],
    );
  }

}