import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spott/models/api_responses/view_profile_api_response.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/resources/api_providers/notifications_api_provider.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/firebase_interaction/firestore_fun.dart';

import 'chat_screen.dart';

class ListOfChatUsers extends StatefulWidget {
  const ListOfChatUsers({Key? key}) : super(key: key);

  @override
  _ListOfChatUsersState createState() => _ListOfChatUsersState();
}

class _ListOfChatUsersState extends State<ListOfChatUsers> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    FireStoreDatabase()
        .setNotificationBubble(AppData.currentUser!.id.toString(), 0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CHATS',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       print(GetStorage().read('Language'));
            //     },
            //     icon: Icon(Icons.menu))
          ],
          elevation: 1,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    //sender
                    .doc(AppData.currentUser!.id.toString())
                    // receiver
                    .collection('contacts')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Network error"),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        try {
                          final String type =
                              snapshot.data!.docs[index]['type'] as String;
                          final messageStatus = snapshot.data!.docs[index]
                              ['messageStatus'] as int;
                          final Timestamp _timeStamp =
                              snapshot.data!.docs[index]['date'] as Timestamp;
                          final hours = _timeStamp.toDate().hour > 12
                              ? _timeStamp.toDate().hour - 12
                              : _timeStamp.toDate().hour;
                          final minutes =
                              _timeStamp.toDate().minute.toString().length == 1
                                  ? '0${_timeStamp.toDate().minute}'
                                  : _timeStamp.toDate().minute;
                          final time =
                              _timeStamp.toDate().hour > 12 ? 'PM' : 'AM';

                          final receiverId =
                              snapshot.data!.docs[index]['receiverId'] as int;

                          final receiverName =
                              snapshot.data!.docs[index]['name'] as String;
                          return InkWell(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('messages')
                                  //sender
                                  .doc(AppData.currentUser!.id.toString())
                                  // receiver
                                  .collection('contacts')
                                  .doc(receiverId.toString())
                                  .update(
                                {
                                  'type': type,
                                  'name': receiverName,
                                  'receiverId': receiverId,
                                  'date': _timeStamp,
                                  'messageStatus': 1
                                },
                              );

                              FirebaseFirestore.instance
                                  .collection('messages')
                                  //sender
                                  .doc(receiverId.toString())
                                  // receiver
                                  .collection('contacts')
                                  .doc(AppData.currentUser!.id.toString())
                                  .update(
                                {
                                  'type': type,
                                  'name': AppData.currentUser!.username,
                                  'receiverId': AppData.currentUser!.id,
                                  'date': _timeStamp,
                                  'messageStatus': 1
                                },
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreenWithUser(
                                    receiverId: receiverId as int,
                                    viewProfileApiResponse:
                                        ViewProfileApiResponse(
                                      profile: User(
                                        username: snapshot.data!.docs[index]
                                            ['name'] as String,
                                      ),
                                    ),
                                    receiverName: snapshot.data!.docs[index]
                                        ['name'] as String,
                                  ),
                                ),
                              );
                            },
                            child: StreamBuilder(
                              stream: users
                                  .doc(
                                      '${snapshot.data!.docs[index]['receiverId']}')
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot2) {
                                int onlineState = 0;
                                if (snapshot2.hasData) {
                                  onlineState = 0;
                                  // snapshot2.data['userState'] as int;
                                }
                                // print("${  snapshot.data!.docs[index]['text'].toString()}");
                                return Container(
                                  height: size.height * 0.1,
                                  margin: const EdgeInsets.only(bottom: 4),
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.01,
                                      horizontal: size.width * 0.03),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(
                                                  right: size.width * 0.02,
                                                ),
                                                width: size.width * 0.14,
                                                height: size.width * 0.14,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xff33cc66),
                                                    shape: BoxShape.circle),
                                                child: Text(
                                                  snapshot
                                                      .data!.docs[index]['name']
                                                      .toString()
                                                      .toUpperCase()
                                                      .substring(0, 1),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: size.width * 0.06,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: size.height * 0.025,
                                                ),
                                                Text(
                                                  snapshot.data!
                                                          .docs[index]['name']
                                                          .toString()
                                                          .toUpperCase()
                                                          .substring(0, 1) +
                                                      snapshot.data!
                                                          .docs[index]['name']
                                                          .toString()
                                                          .substring(1),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: size.width * 0.04,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                if (type == 'text')
                                                  Expanded(
                                                    child: Container(
                                                      width: size.width * 0.58,
                                                      child: Text(
                                                        snapshot.data!
                                                            .docs[index]['text']
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: size.width *
                                                              0.035,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                if (type == 'image')
                                                  SizedBox(
                                                    width: size.width * 0.6,
                                                    child: Text(
                                                      'Image',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            size.width * 0.035,
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                if (type == 'voice')
                                                  SizedBox(
                                                    width: size.width * 0.63,
                                                    child: Text(
                                                      'Voice message',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            size.width * 0.035,
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "$hours:$minutes $time",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: size.width * 0.037,
                                            ),
                                          ),
                                          SizedBox(
                                            child: messageStatus == 0
                                                ? Container(
                                                    width: size.width * 0.024,
                                                    height: size.width * 0.024,
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .orange.shade600,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )
                                                : Container(),
                                          )

                                          /// this code for show online and offline of chat user
                                          // Text(
                                          //   onlineState == 1
                                          //       ? "Online"
                                          //       : "Offline",
                                          //   style: TextStyle(
                                          //     color: onlineState == 1
                                          //         ? Colors.green
                                          //         : Colors.red,
                                          //     fontWeight: FontWeight.w700,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } catch (e) {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
