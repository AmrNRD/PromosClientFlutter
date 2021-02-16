import 'package:PromoMeFlutter/data/models/user_model.dart';
import 'package:PromoMeFlutter/utils/app.localization.dart';
import 'package:flutter/material.dart';

import '../../../../utils/core.util.dart';
import '../../../style/app.dimens.dart';

class ProfileTagComponent extends StatelessWidget {
  final User user;
  final bool showPoints;

  const ProfileTagComponent({Key key, @required this.user, this.showPoints=true,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 60,
            width: 60,
            child: ImageProcessor().customImage(
              context,
              user?.image,
            ),
          ),
          SizedBox(
            width: AppDimens.marginDefault16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user?.name ?? "",
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                user?.email ?? "",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                AppLocalizations.of(context).translate("points",replacement: (user?.points??0).toString()),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
