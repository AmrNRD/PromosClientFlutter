import 'dart:async';

import 'package:PromoMeFlutter/bloc/post/post_bloc.dart';
import 'package:PromoMeFlutter/ui/common/genearic.state.component.dart';
import 'package:PromoMeFlutter/ui/common/post.card.component.dart';
import 'package:PromoMeFlutter/ui/style/app.colors.dart';
import 'package:PromoMeFlutter/utils/app.localization.dart';
import 'package:PromoMeFlutter/utils/constants.dart';
import 'package:PromoMeFlutter/utils/core.util.dart';
import 'package:PromoMeFlutter/utils/delayed_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:qr_flutter/qr_flutter.dart';


class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(GetAllPastsEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsetsDirectional.only(top: 50),
            child:BlocBuilder<PostBloc,PostState>(
              builder: (context,state){
                if(state is PostLoading){
                  return Container(margin: EdgeInsets.all(30),alignment: Alignment.center,child: SemiCircleSpinIndicator(color: Theme.of(context).accentColor));
                } else if(state is PostsLoaded){
                  return  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: state.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DelayedAnimation(
                        child: Container(
                          margin: EdgeInsetsDirectional.only(
                              bottom: index + 1 == state.posts.length ? 0 : 16),
                          child: PostCardComponent(post: state.posts[index]),
                        ),
                        delay: 150*index,
                      );
                    },
                  );
                }else if(state is PostError){
                  return Container(
                    alignment: Alignment.center,
                    child: GenericState(
                      size: 180,
                      margin: 8,
                      fontSize: 16,
                      removeButton: false,
                      imagePath: "assets/icons/sad.svg",
                      titleKey: AppLocalizations.of(context).translate("error_occurred",replacement: ""),
                      bodyKey: state.message,
                      onPress: ()=>BlocProvider.of<PostBloc>(context).add(GetAllPastsEvent()),
                      buttonKey: "reload",
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  child: GenericState(
                    size: 180,
                    margin: 8,
                    fontSize: 16,
                    removeButton: false,
                    imagePath: "assets/icons/sad.svg",
                    titleKey: AppLocalizations.of(context).translate("error_occurred",replacement: ""),
                    onPress: ()=>BlocProvider.of<PostBloc>(context).add(GetAllPastsEvent()),
                    buttonKey: "reload",
                  ),
                );
              },
            ),
          ),
        ));
  }





}
