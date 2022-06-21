import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spott/models/api_responses/view_profile_api_response.dart';
import 'package:spott/resources/api_providers/notifications_api_provider.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/firebase_interaction/firestore_fun.dart';
import 'package:spott/utils/constants/app_colors.dart';

import 'components/message_bubble.dart';

class ChatScreenWithUser extends StatefulWidget {
  static const String routeName = 'chat_screen';
  final String? receiverName;
  final int? receiverId;
  final ViewProfileApiResponse? viewProfileApiResponse;

  const ChatScreenWithUser({
    required this.receiverId,
    required this.receiverName,
    required this.viewProfileApiResponse,
  });

  @override
  _ChatScreenWithUserState createState() => _ChatScreenWithUserState();
}

class _ChatScreenWithUserState extends State<ChatScreenWithUser>
    with WidgetsBindingObserver {
  final messageTextController = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String msg = '';

  /// Voice recorder variables
  Duration? duration;
  Timer? _timer;
  Timer? _ampTimer;
  late FlutterSoundRecorder _audioRecorder;
  bool voiceIsRecorded = false;

  /// Image variables
  late String messageText;
  XFile? image;
  bool imageIsSelected = false;
  bool fileIsUploading = false;

  @override
  void initState() {
    print('receiver id => ${widget.receiverId}');
    _audioRecorder = FlutterSoundRecorder();
    Permission.microphone.request().then((value) {
      if (value == PermissionStatus.granted) {
        _audioRecorder.openAudioSession();
      }
    });

    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      /// set state here online
      FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 1);
    });

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.closeAudioSession();
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 1);

        break;
      case AppLifecycleState.inactive:
        FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 2);

        break;
      case AppLifecycleState.paused:
        FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 3);

        break;
      case AppLifecycleState.detached:
        FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 0);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    print("\n\n");
    print(AppData.currentUser!.id.toString());
    print("\n\n");
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black,
        title: Text(
          '${widget.receiverName.toString()[0].toUpperCase()}${widget.receiverName.toString().substring(1)}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.06,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [

              PopupMenuItem(
                child: GestureDetector(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: AppColors.green,
                      ),
                      Text(
                        'Delete chat',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  onTap: () async {
                    FirebaseFirestore.instance
                        .collection('messages')
                        .doc(AppData.currentUser!.id.toString())
                        .collection("contacts")
                        .doc(widget.receiverId.toString())
                        .get()
                        .then((snapshot) {
                      snapshot.reference.delete();
                      // for (DocumentSnapshot doc in snapshot.i) {
                      //   doc.reference.delete();
                      // }
                    });

                    FirebaseFirestore.instance
                        .collection('messages')
                        .doc(AppData.currentUser!.id.toString())
                        .collection(widget.receiverId.toString())
                        .get()
                        .then((snapshot) {
                      for (DocumentSnapshot doc in snapshot.docs) {
                        doc.reference.delete();
                      }
                    }).then((value) => {Navigator.pop(context)});

                    // FirebaseFirestore.instance
                    //     .collection('messages')
                    //     //sender
                    //     .doc(AppData.currentUser!.id.toString())
                    //     .collection(widget.receiverId.toString()).doc().delete()
                    //     .whenComplete(() => {
                    //   // showSnackBar(context: context, message: 'coming soon');
                    //
                    //     });
                  },
                ),

              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (fileIsUploading)
              const LinearProgressIndicator(
                backgroundColor: AppColors.green,
              ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(AppData.currentUser!.id.toString())
                  .collection(widget.receiverId.toString())
                  .orderBy('date', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data.docs.reversed;
                final List<MessageBubble> messageBubbles = [];

                for (final message in messages) {
                  String messageText = '';
                  String link = '';
                  final String type = message.get('type') as String;
                  if (type == 'text') {
                    messageText = message.get('text') as String;
                  } else {
                    link = message.get('link') as String;
                  }

                  final Timestamp _timeStamp = message.get('date') as Timestamp;
                  final messageSender = message.get('sender');

                  final currentUser = AppData.currentUser!.id;
                  if (currentUser == messageSender) {}
                  final hours = _timeStamp.toDate().hour > 12
                      ? _timeStamp.toDate().hour - 12
                      : _timeStamp.toDate().hour;
                  final minutes =
                      _timeStamp.toDate().minute.toString().length == 1
                          ? '0${_timeStamp.toDate().minute}'
                          : _timeStamp.toDate().minute;
                  final time = _timeStamp.toDate().hour > 12 ? 'PM' : 'AM';
                  final messageBubble = MessageBubble(
                    type: type,
                    userModel: widget.viewProfileApiResponse,
                    text: messageText,
                    link: link,
                    isMe: messageSender == AppData.currentUser!.id.toString(),
                    time: '$hours:$minutes $time',
                    timestamp: _timeStamp,
                  );
                  //print("currentUser $currentUser messageSender $messageSender");
                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    reverse: true,
                    children: messageBubbles,
                  ),
                );
              },
            ),

            /// sender text box
            Container(
              margin: EdgeInsets.only(
                left: size.width * 0.04,
                bottom: 6,
                right: size.width * 0.04,
              ),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.14),
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (voiceIsRecorded == false)
                    InkWell(
                      onTap: () {
                        selectImage(context, size);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 10, top: 13, bottom: 10),
                        child: Transform.rotate(
                          angle: 49.4,
                          child: const Icon(
                            Icons.attachment_rounded,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                  if (imageIsSelected == false && voiceIsRecorded == false)
                    Expanded(
                      child: TextField(
                        maxLines: 20,
                        autofocus: false,
                        minLines: 1,
                        controller: messageTextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type a Message",
                          hintStyle: TextStyle(
                            color: const Color(0xffcbcaca),
                            fontSize: size.width * 0.045,
                          ),
                        ),
                      ),
                    ),
                  if (imageIsSelected == true && voiceIsRecorded == false)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Image.file(
                          File(image!.path),
                        ),
                      ),
                    ),
                  if (voiceIsRecorded == true)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.mic,
                              color: AppColors.green,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.003),
                              child: Text(
                                '${minutes < 10 ? '0$minutes' : '$minutes'}:${localSeconds < 10 ? '0$localSeconds' : '$localSeconds'}',
                                style: TextStyle(fontSize: size.width * 0.04),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _timer?.cancel();
                                  voiceIsRecorded = false;
                                  localSeconds = minutes = 0;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: size.height * 0.003,
                                ),
                                child: Text(
                                  'click to cancel',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (voiceIsRecorded == false)
                    InkWell(
                      onTap: () {
                        setState(() {
                          startRecording();
                          Future.delayed(const Duration(milliseconds: 1010),
                              () {
                            voiceIsRecorded = true;
                          });
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 10),
                        child: const Icon(
                          Icons.mic_none,
                          color: Color(0xffBCD0E2),
                        ),
                      ),
                    ),
                  if (voiceIsRecorded == true)
                    InkWell(
                      onTap: () {
                        stopRecorder(context);
                        setState(() {
                          _timer!.cancel();
                          minutes = 0;
                          localSeconds = 0;
                          voiceIsRecorded = false;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 18,
                          bottom: 13,
                        ),
                        child: const Text(
                          'Send',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  if (voiceIsRecorded == false)
                    InkWell(
                      onTap: () {
                        try {
                          msg = messageTextController.text;
                          print(messageTextController.text);
                          if (messageTextController.text
                                  .toString()
                                  .isNotEmpty &&
                              image == null) {
                            FirebaseFirestore.instance
                                .collection('messages')
                                //sender
                                .doc(AppData.currentUser!.id.toString())
                                // receiver
                                .collection(widget.receiverId.toString())
                                .add(
                              {
                                'type': 'text',
                                'text': msg,
                                'sender': AppData.currentUser!.id.toString(),
                                'receiver': widget.receiverId.toString(),
                                'date': DateTime.now(),
                              },
                            );

                            /// it will create chats screen element
                            /// it will create chats history for current user
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.receiverId.toString())
                                .get()
                                .then((value) async {
                              if (value.get('userState') == 1) {
                                print(
                                    "Current user id => ${value.get('userState')}");
                                await FirebaseFirestore.instance
                                    .collection('messages')
                                    //sender
                                    .doc(AppData.currentUser!.id.toString())
                                    // receiver
                                    .collection('contacts')
                                    .doc(widget.receiverId.toString())
                                    .set(
                                  {
                                    'type': 'text',
                                    'text': msg,
                                    'name': widget.receiverName,
                                    'receiverId': widget.receiverId,
                                    'date': DateTime.now(),
                                    'messageStatus': 1
                                  },
                                );

                                await FirebaseFirestore.instance
                                    .collection('messages')
                                    //sender
                                    .doc(widget.receiverId.toString())
                                    // receiver
                                    .collection('contacts')
                                    .doc(AppData.currentUser!.id.toString())
                                    .set(
                                  {
                                    'type': 'text',
                                    'text': msg,
                                    'name': AppData.currentUser!.username,
                                    'receiverId': AppData.currentUser!.id,
                                    'date': DateTime.now(),
                                    'messageStatus': 0
                                  },
                                );
                              } else {
                                await FirebaseFirestore.instance
                                    .collection('messages')
                                    //sender
                                    .doc(AppData.currentUser!.id.toString())
                                    // receiver
                                    .collection('contacts')
                                    .doc(widget.receiverId.toString())
                                    .set(
                                  {
                                    'type': 'text',
                                    'text': msg,
                                    'name': widget.receiverName,
                                    'receiverId': widget.receiverId,
                                    'date': DateTime.now(),
                                    'messageStatus': 1
                                  },
                                );

                                await FirebaseFirestore.instance
                                    .collection('messages')
                                    //sender
                                    .doc(widget.receiverId.toString())
                                    // receiver
                                    .collection('contacts')
                                    .doc(AppData.currentUser!.id.toString())
                                    .set(
                                  {
                                    'type': 'text',
                                    'text': msg,
                                    'name': AppData.currentUser!.username,
                                    'receiverId': AppData.currentUser!.id,
                                    'date': DateTime.now(),
                                    'messageStatus': 0
                                  },
                                );
                              }
                            });
                            String message = messageTextController.text;
                            print("Message => ${message}");
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.receiverId.toString())
                                .get()
                                .then((value) async {
                              if (value.get('userState') == 1) {
                                print(
                                    "message inner => ${messageTextController.text}");
                                print("message inner => ${message}");

                                await FirebaseFirestore.instance
                                    .collection('messages')
                                    //sender
                                    .doc(widget.receiverId.toString())
                                    // receiver
                                    .collection(
                                        AppData.currentUser!.id.toString())
                                    .add(
                                  {
                                    'type': 'text',
                                    'text': message,
                                    'sender':
                                        AppData.currentUser!.id.toString(),
                                    'receiver': widget.receiverId.toString(),
                                    'date': DateTime.now(),
                                    'messageStatus': 1
                                  },
                                );
                              } else {
                                await FirebaseFirestore.instance
                                    .collection('messages')
                                    //sender
                                    .doc(widget.receiverId.toString())
                                    // receiver
                                    .collection(
                                        AppData.currentUser!.id.toString())
                                    .add(
                                  {
                                    'type': 'text',
                                    'text': msg,
                                    'sender':
                                        AppData.currentUser!.id.toString(),
                                    'receiver': widget.receiverId.toString(),
                                    'date': DateTime.now(),
                                    'messageStatus': 0
                                  },
                                );
                              }
                            });

                            NotificationsApiProvider().sendMessageNotification(
                                widget.receiverId.toString(), context);
                            FireStoreDatabase().setNotificationBubble(
                                widget.receiverId.toString(), 1);
                          } else if (image != null) {
                            print("called...........");
                            setState(() {
                              fileIsUploading = true;
                              imageIsSelected = false;
                            });
                            firebase_storage.Reference obj = firebase_storage
                                .FirebaseStorage.instance
                                .ref()
                                .child(basename(image!.path));

                            obj
                                .putFile(File(image!.path))
                                .whenComplete(() async {
                              obj.getDownloadURL().then((value) async {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.receiverId.toString())
                                    .get()
                                    .then((value) async {
                                  if (value.get('userState') == 1) {
                                    /// it will create chats screen element
                                    await FirebaseFirestore.instance
                                        .collection('messages')
                                        //sender
                                        .doc(AppData.currentUser!.id.toString())
                                        // receiver
                                        .collection('contacts')
                                        .doc(widget.receiverId.toString())
                                        .set(
                                      {
                                        'type': 'image',
                                        'name': widget.receiverName,
                                        'receiverId': widget.receiverId,
                                        'date': DateTime.now(),
                                        'messageStatus': 1
                                      },
                                    ).whenComplete(() {
                                      print("Message sent successfully");
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('messages')
                                        //sender
                                        .doc(widget.receiverId.toString())
                                        // receiver
                                        .collection('contacts')
                                        .doc(AppData.currentUser!.id.toString())
                                        .set(
                                      {
                                        'type': 'image',
                                        'name': AppData.currentUser!.username,
                                        'receiverId': AppData.currentUser!.id,
                                        'date': DateTime.now(),
                                        'messageStatus': 1
                                      },
                                    );
                                  } else {
                                    /// it will create chats screen element
                                    await FirebaseFirestore.instance
                                        .collection('messages')
                                        //sender
                                        .doc(AppData.currentUser!.id.toString())
                                        // receiver
                                        .collection('contacts')
                                        .doc(widget.receiverId.toString())
                                        .set(
                                      {
                                        'type': 'image',
                                        'name': widget.receiverName,
                                        'receiverId': widget.receiverId,
                                        'date': DateTime.now(),
                                        'messageStatus': 1
                                      },
                                    ).whenComplete(() {
                                      print("Message sent successfully 2");
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('messages')
                                        //sender
                                        .doc(widget.receiverId.toString())
                                        // receiver
                                        .collection('contacts')
                                        .doc(AppData.currentUser!.id.toString())
                                        .set(
                                      {
                                        'type': 'image',
                                        'name': AppData.currentUser!.username,
                                        'receiverId': AppData.currentUser!.id,
                                        'date': DateTime.now(),
                                        'messageStatus': 0
                                      },
                                    );
                                  }
                                });

                                await FirebaseFirestore.instance
                                    .collection('messages')
                                    //sender
                                    .doc(widget.receiverId.toString())
                                    // receiver
                                    .collection(
                                        AppData.currentUser!.id.toString())
                                    .add(
                                  {
                                    'type': 'image',
                                    'link': value,
                                    'sender':
                                        AppData.currentUser!.id.toString(),
                                    'receiver': widget.receiverId.toString(),
                                    'date': DateTime.now(),
                                  },
                                );

                                await FirebaseFirestore.instance
                                    .collection('messages')
                                    //sender
                                    .doc(AppData.currentUser!.id.toString())
                                    // receiver
                                    .collection(widget.receiverId.toString())
                                    .add(
                                  {
                                    'type': 'image',
                                    'link': value,
                                    'sender':
                                        AppData.currentUser!.id.toString(),
                                    'receiver': widget.receiverId.toString(),
                                    'date': DateTime.now(),
                                  },
                                );
                              });
                              NotificationsApiProvider()
                                  .sendMessageNotification(
                                      widget.receiverId.toString(), context);
                              FireStoreDatabase().setNotificationBubble(
                                  widget.receiverId.toString(), 1);

                              setState(() {
                                image = null;
                                fileIsUploading = false;
                              });
                            });
                          }
                          Future.delayed(Duration(milliseconds: 100), () {
                            messageTextController.text = '';
                          });
                        } catch (e) {}
                      },
                      child: Container(
                          margin: const EdgeInsets.only(
                              right: 10, top: 5, left: 5, bottom: 5),
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          child: Image.asset('assets/icons/send_btn.png')),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectImage(BuildContext context, Size size) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            width: size.width,
            height: size.height * 0.15,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.only(top: 10, left: 15, bottom: 5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final ImagePicker _picker = ImagePicker();

                      image = await _picker.pickImage(
                          source: ImageSource.camera, imageQuality: 60);
                      if (image != null) {
                        imageIsSelected = true;
                      }
                      setState(() {});
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera_alt,
                          color: AppColors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Camera'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);

                      final ImagePicker _picker = ImagePicker();

                      image = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 60);
                      if (image != null) {
                        imageIsSelected = true;
                      }
                      setState(() {});
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.image,
                          color: AppColors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  int minutes = 0;
  int localSeconds = 0;

  startRecording() {
    _audioRecorder.startRecorder(
      toFile: '${DateTime.now()}.aac',
    );
    startTimer();
  }

  Future<void> stopRecorder(BuildContext context) async {
    _timer!.cancel();
    final path = await _audioRecorder.stopRecorder();
    print('path =>  $path');
    firebase_storage.Reference obj =
        firebase_storage.FirebaseStorage.instance.ref().child(basename(path!));
    setState(() {
      fileIsUploading = true;
    });
    obj.putFile(File(path)).whenComplete(() {
      obj.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('messages')
            //sender
            .doc(AppData.currentUser!.id.toString())
            // receiver
            .collection(widget.receiverId.toString())
            .add(
          {
            'type': 'voice',
            'link': value,
            'sender': AppData.currentUser!.id.toString(),
            'receiver': widget.receiverId.toString(),
            'date': DateTime.now(),
          },
        );

        FirebaseFirestore.instance
            .collection('messages')
            //sender
            .doc(widget.receiverId.toString())
            // receiver
            .collection(AppData.currentUser!.id.toString())
            .add(
          {
            'type': 'voice',
            'link': value,
            'sender': AppData.currentUser!.id.toString(),
            'receiver': widget.receiverId.toString(),
            'date': DateTime.now(),
          },
        );

        /// it will create chats screen element

        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.receiverId.toString())
            .get()
            .then((value) {
          if (value.get('userState') == 1) {
            FirebaseFirestore.instance
                .collection('messages')
                //sender
                .doc(AppData.currentUser!.id.toString())
                // receiver
                .collection('contacts')
                .doc(widget.receiverId.toString())
                .set(
              {
                'type': 'voice',
                'name': widget.receiverName,
                'receiverId': widget.receiverId,
                'date': DateTime.now(),
                'messageStatus': 0
              },
            );

            FirebaseFirestore.instance
                .collection('messages')
                //sender
                .doc(widget.receiverId.toString())
                // receiver
                .collection('contacts')
                .doc(AppData.currentUser!.id.toString())
                .set(
              {
                'type': 'voice',
                'name': AppData.currentUser!.username,
                'receiverId': AppData.currentUser!.id,
                'date': DateTime.now(),
                'messageStatus': 1
              },
            );
          } else {
            FirebaseFirestore.instance
                .collection('messages')
                //sender
                .doc(AppData.currentUser!.id.toString())
                // receiver
                .collection('contacts')
                .doc(widget.receiverId.toString())
                .set(
              {
                'type': 'voice',
                'name': widget.receiverName,
                'receiverId': widget.receiverId,
                'date': DateTime.now(),
                'messageStatus': 0
              },
            );

            FirebaseFirestore.instance
                .collection('messages')
                //sender
                .doc(widget.receiverId.toString())
                // receiver
                .collection('contacts')
                .doc(AppData.currentUser!.id.toString())
                .set(
              {
                'type': 'voice',
                'name': AppData.currentUser!.username,
                'receiverId': AppData.currentUser!.id,
                'date': DateTime.now(),
                'messageStatus': 0
              },
            );
          }
        });
      }).whenComplete(() {
        setState(() {
          fileIsUploading = false;
        });

        NotificationsApiProvider()
            .sendMessageNotification(widget.receiverId.toString(), context);
        // FireStoreDatabase()
        //     .setNotificationBubble(widget.receiverId.toString(), 1);
      });
    });
  }

  void startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      print(localSeconds);

      if (localSeconds == 60) {
        localSeconds = 0;
        minutes = minutes + 1;
      }

      setState(() {
        duration = Duration(minutes: minutes, seconds: localSeconds);
      });
      setState(() {
        if (localSeconds == 60) {
          localSeconds = 0;
        } else if (localSeconds >= 0 && localSeconds < 61) {
          localSeconds++;
        }
      });
    });
  }
}
