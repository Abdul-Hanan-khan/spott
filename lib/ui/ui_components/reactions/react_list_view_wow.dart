import 'package:flutter/material.dart';
import 'package:spott/models/api_responses/post_reacts_model.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/utils/constants/app_colors.dart';

class WowListViewScreen extends StatefulWidget {
  final PostReactsModel reacts;
  const WowListViewScreen({Key? key, required this.reacts}) : super(key: key);

  @override
  _WowListViewScreenState createState() => _WowListViewScreenState();
}

class _WowListViewScreenState extends State<WowListViewScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: widget.reacts.data!.length,
        itemBuilder: (context, index) {
          if (widget.reacts.data![index].reactKey == 3) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProfileScreen(
                            widget.reacts.data![index].user)));
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.03),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.1,
                      height: size.width * 0.1,
                      decoration: BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                          image: widget.reacts.data![index].user!.profilePicture
                                      .toString() !=
                                  null
                              ? DecorationImage(
                                  image: NetworkImage(widget
                                      .reacts.data![index].user!.profilePicture
                                      .toString()),
                                )
                              : null),
                      child: widget.reacts.data![index].user!.profilePicture ==
                              null
                          ? Text(
                              widget.reacts.data![index].user!.username
                                  .toString()
                                  .toUpperCase()
                                  .substring(0, 1),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Text(
                      widget.reacts.data![index].user!.username.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.04),
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}
