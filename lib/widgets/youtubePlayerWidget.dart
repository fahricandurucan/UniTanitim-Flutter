// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class YoutubePlayerWidget extends StatelessWidget {
//   YoutubePlayerController _controller = YoutubePlayerController(
//     initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=W0r8MOryzbE&t=669s")!,
//     flags: YoutubePlayerFlags(
//       autoPlay: false,
//     ),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
//         player: YoutubePlayer(
//           controller: _controller,
//         ),
//         builder: (context, player) {
//           return Scaffold(
//             body: Column(
//               children: [
//                 Text("sfghfhffjfhuhuryygrudııdgdsdfg"),
//                 player,
//                 Text("sfgsdfg"),
//                 //some other widgets
//               ],
//             ),
//           );
//         }
//     );
//
//   }
// }