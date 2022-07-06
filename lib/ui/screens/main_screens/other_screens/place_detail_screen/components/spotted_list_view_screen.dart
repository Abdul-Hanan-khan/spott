import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/spotted_list_view_cubit/spotted_list_view_cubit.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/post_card_view.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';

class SpottedListViewScreen extends StatefulWidget {
  final placeId;

  const SpottedListViewScreen({Key? key, required this.placeId})
      : super(key: key);

  @override
  _SpottedListViewScreenState createState() => _SpottedListViewScreenState();
}

class _SpottedListViewScreenState extends State<SpottedListViewScreen> {
  ScrollController scrollController = ScrollController();

  // @override
  // void initState() {
  //   context.read<SpottedListViewCubit>().getSpottedListView(widget.placeId);
  //
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {

    print("PLACE Id .......... ${widget.placeId.toString()}");
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SpottedListViewCubit()..getSpottedListView(
          widget.placeId.toString(),
        ),
      child: BlocConsumer<SpottedListViewCubit, SpottedListViewState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  LocaleKeys.spotted.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                elevation: 1,
              ),
              body: state is SpottedListViewSuccessState
                  ?  Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: ListView.separated(
                            controller: scrollController,
                            itemCount: state.placeSpottedListModel.data!.length,
                            itemBuilder: (context, index) {
                              print(state.placeSpottedListModel.data!.length);
                              return PostCardView(index);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 20,
                            ),
                          ),
                        )
                  : state is SpottedListViewLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : notSpottedWidget(),
            ),
          );
        },
      ),
    );
  }

  Widget notSpottedWidget(){
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height *0.9,
      width: size.width,
      decoration: BoxDecoration(
        color: Color(0xf0f4fa),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/wth_4.gif',width: 200,height: 200,),
          SizedBox(height: 10,),
          Text("This place is not spotted yet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          SizedBox(height: size.height *0.2,),

        ],
      ),
    );
  }
}
