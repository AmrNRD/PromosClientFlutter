import 'package:PromoMeFlutter/data/models/post_model.dart';
import 'package:PromoMeFlutter/ui/style/app.colors.dart';
import 'package:PromoMeFlutter/utils/core.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class PostCardComponent extends StatelessWidget {
  final Post post;

  const PostCardComponent({Key key,@required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  margin: EdgeInsetsDirectional.only(end: 16),
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: ImageProcessor.image(
                      url: post.user.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Text(
                                post.user.name,
                                style: Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 24),
                              child: Text(
                                  DateFormat('h:mm a dd-MM-yyyy',Root.locale.toString()).format(post.lastUpdate),
                                style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 50,end: 20),
              child: Text(
                post.content,
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
