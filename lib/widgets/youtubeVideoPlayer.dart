import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  String url;

  YoutubeVideoPlayer(this.url);

  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}


class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {

  String convertToEmbeddedUrl(String url) {
    final videoId = url.split("v=")[1];
    log("https://www.youtube.com/embed/$videoId?controls=1", error: "ERROR");
    return "https://www.youtube.com/embed/$videoId?controls=1";

  }

  @override
  Widget build(BuildContext context) {
    late InAppWebViewController _controller;
    return Scaffold(
      //body: WebViewWidget(controller: controller)
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
           crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
        )
        ),

        initialUrlRequest: URLRequest(
          url: Uri.parse(
              convertToEmbeddedUrl(widget.url)),
        ),

        onEnterFullscreen: (controller) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        },

        shouldOverrideUrlLoading: (controller, navigationAction) async {
          print("------------------shouldOverrideUrlLoading");
          if (navigationAction.request.url?.host== 'www.youtube.com' &&
              navigationAction.request.url?.path == '/') {
            // Block navigation to the YouTube main page
            return NavigationActionPolicy.CANCEL;
          }
          // Allow navigation to all other URLs
          return NavigationActionPolicy.CANCEL;
        },
      ),
    );
  }
}
