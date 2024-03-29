import 'dart:async';

import 'package:PromoMeFlutter/bloc/post/post_bloc.dart';
import 'package:PromoMeFlutter/data/models/post_model.dart';
import 'package:PromoMeFlutter/ui/common/comment.card.component.dart';
import 'package:PromoMeFlutter/ui/common/comments_sheets.dart';
import 'package:PromoMeFlutter/ui/common/custom_appbar.dart';
import 'package:PromoMeFlutter/ui/common/form.input.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../env.dart';
import '../../../main.dart';


class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

  List<Post>posts=[];
  Post selectedPost;
  bool isLoading=true;
  bool isError=false;
  String errorMessage="";
  PersistentBottomSheetController _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(GetAllPastsEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        actionButtons: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF0483D),
                child: Text(
                  AppLocalizations.of(context).translate("points",replacement: (Root.user.points??0).toString()),
                  style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
                ),
                onPressed: () {Navigator.pushNamed(context, Env.sideMenuPage);}
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: 10),
                child: BlocListener<PostBloc, PostState>(
                  listener: (BuildContext context, PostState state) {
                    if (state is PostLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    } else if (state is PostsLoaded) {
                      setState(() {
                        posts = state.posts;
                        isLoading = false;
                      });
                    } else if (state is PostLoaded) {
                      setState(() {

                        isLoading = false;
                        int index = posts.indexWhere(
                            (element) => element.id == state.post.id);
                        print(index);
                        if (index != -1) posts[index] = state.post;
                      });
                      if (_controller != null)
                        _controller.setState(() {
                          int index = posts.indexWhere(
                              (element) => element.id == state.post.id);
                          if (index != -1) selectedPost = state.post;
                        });
                    } else if (state is PostError) {
                      setState(() {
                        errorMessage = state.message;
                        isError = true;
                      });
                    }
                  },
                  child: isLoading
                      ? Container(
                    margin: EdgeInsets.all(30),
                    alignment: Alignment.center,
                    child: Shimmer.fromColors(
                      baseColor: AppColors.primaryColor,
                      highlightColor: AppColors.white,
                      child: Image.asset(
                        "assets/images/logo2.png",
                        height: screenAwareSize(70, context),
                        width: screenAwareWidth(70, context),
                      ),
                    ),
                  )
                      : isError
                          ? Container(
                              alignment: Alignment.center,
                              child: GenericState(
                                size: 180,
                                margin: 8,
                                fontSize: 16,
                                removeButton: false,
                                imagePath: "assets/icons/box_icon.svg",
                                titleKey: AppLocalizations.of(context).translate("error_occurred", replacement: ""),
                                bodyKey: errorMessage,
                                onPress: () => BlocProvider.of<PostBloc>(context).add(GetAllPastsEvent()),
                                buttonKey: "reload",
                              ),
                            )
                      :posts.isNotEmpty?  ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: posts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return DelayedAnimation(
                                  child: Container(
                                    margin: EdgeInsetsDirectional.only(
                                        bottom:
                                            index + 1 == posts.length ? 0 : 24),
                                    child: PostCardComponent(
                                      post: posts[index],
                                      onCommentsClick: () {
                                        setState(() {
                                          selectedPost = posts[index];
                                        });
                                        onCommentClick();
                                      },
                                    ),
                                  ),
                                  delay: 150 * index,
                                );
                              },) : Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  child: GenericState(
                                    size: 40,
                                    margin: 8,
                                    fontSize: 16,
                                    removeButton: true,
                                    imagePath: "assets/icons/box_icon.svg",
                                    titleKey: AppLocalizations.of(context).translate("No posts!", defaultText: "No posts!"),
                                    bodyKey: AppLocalizations.of(context).translate("There is no posts at the moment"),
                                  ),
                                ),
                ),
              ),
            ],
          ),
        ));
  }

Future onCommentClick() async {
  _controller = await _scaffoldKey.currentState.showBottomSheet(
    (builder) {
      return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: FractionallySizedBox(
                heightFactor: 0.9,
                child: CommentsSheet(selectedPost: selectedPost),
              ),
            );
          });
    },
    backgroundColor: Colors.transparent,
    elevation: 10,
  );
}



}
