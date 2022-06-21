import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';

class ProfileImagePickerView extends StatefulWidget {
  final Function(Uint8List? _image)? onImageSelection;
  final User? _user;
  const ProfileImagePickerView(
    this._user, {
    Key? key,
    this.onImageSelection,
  }) : super(key: key);

  @override
  _ProfileImagePickerViewState createState() => _ProfileImagePickerViewState();
}

class _ProfileImagePickerViewState extends State<ProfileImagePickerView> {
  Uint8List? _pickedImage;

  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedImage = await pickedFile.readAsBytes();
      setState(() {});
      widget.onImageSelection?.call(
        _pickedImage,
      );
    } else {
      debugPrint('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          if (_pickedImage != null)
            CircleAvatar(
              radius: 30,
              backgroundImage: MemoryImage(_pickedImage!),
            )
          else
            UserProfileImageView(
              widget._user,
              radius: 30,
            ),
          const Icon(
            CupertinoIcons.add_circled_solid,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
