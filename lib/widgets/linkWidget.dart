import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkWidget extends StatelessWidget {
  String link;
   String imageLink;

  LinkWidget({required this.link, required this.imageLink});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12,right: 12,bottom: 12,top: 12),
      child: Column(
        children: [
          Row(children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              height: 40,
              child: Image.network(imageLink)),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  if(link.contains("www.")){
                    launchUrl(Uri.parse(link));
                  }else if (!link.contains(".")){
                    final Uri emailLaunchUri = Uri(
                      scheme: 'tel',
                      path: link,
                    );
                    launchUrl(emailLaunchUri);
                  }else if(link.contains("@")){
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: link,
                    );
                    launchUrl(emailLaunchUri);
                  }

                },
                child: Text(link, style: TextStyle( fontSize: 16),overflow: TextOverflow.fade,maxLines: 1,)

                ),
            ),
          ],
          ),
        ],
      ),
    );
  }
}