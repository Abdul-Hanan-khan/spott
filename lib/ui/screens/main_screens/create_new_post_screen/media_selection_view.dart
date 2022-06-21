import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spott/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/enums.dart';

class MediaSelectionView extends StatefulWidget {
  final Function(Uint8List? _media, MediaType? _mediaType) onMediaSelection;
  const MediaSelectionView({Key? key, required this.onMediaSelection})
      : super(key: key);

  @override
  _MediaSelectionViewState createState() => _MediaSelectionViewState();
}

class _MediaSelectionViewState extends State<MediaSelectionView> {
  Uint8List? _pickedImage;
  Uint8List? _pickedVideo;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostCubitState>(
      listener: (context, state) {
        if (state is PostCreatedSuccessfully) {
          _removeSelectedMedia();
        }
      },
      child: ListTile(
        leading: (_pickedImage != null)
            ? Image.memory(
                _pickedImage!,
                height: 40,
                width: 40,
              )
            : (_pickedVideo != null)
                ? Icon(Icons.movie, color: Theme.of(context).primaryColor)
                : SvgPicture.asset(
                    'assets/icons/no_image.svg',
                    height: 30,
                    color: Colors.black,
                  ),
        title: Text((_pickedImage != null)
            ? 'Image'
            : (_pickedVideo != null)
                ? 'Video'
                : 'Media'),
        trailing: Icon(
          (_pickedImage != null || _pickedVideo != null)
              ? Icons.close
              : Icons.add,
          color: Colors.black,
          size: 25,
        ),
        onTap: (_pickedImage != null || _pickedVideo != null)
            ? _removeSelectedMedia
            : _onAddMediaButtonTapped,
      ),
    );
  }

  Future<void> _onAddMediaButtonTapped() async {
    final _mediaType = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              dense: true,
              leading: Icon(
                Icons.image,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(LocaleKeys.image.tr()),
              onTap: () {
                Navigator.of(context).pop(MediaType.image);
              },
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.movie, color: Theme.of(context).primaryColor),
              title: Text(LocaleKeys.video.tr()),
              onTap: () {
                Navigator.of(context).pop(MediaType.video);
              },
            ),
          ],
        ),
      ),
    );
    if (_mediaType == MediaType.image) {
      _pickImage();
    } else if (_mediaType == MediaType.video) {
      _pickVideo();
    }
  }

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedImage = await pickedFile.readAsBytes();
      _pickedVideo = null;
      setState(() {});
      widget.onMediaSelection.call(_pickedImage, MediaType.image);
    } else {
      debugPrint('No image selected.');
    }
  }

  Future _pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedVideo = await pickedFile.readAsBytes();
      _pickedImage = null;
      setState(() {});
      widget.onMediaSelection.call(_pickedVideo, MediaType.video);
    } else {
      debugPrint('No video selected.');
    }
  }

  void _removeSelectedMedia() {
    _pickedImage = null;
    _pickedVideo = null;
    widget.onMediaSelection.call(null, null);
    setState(() {});
  }
}
