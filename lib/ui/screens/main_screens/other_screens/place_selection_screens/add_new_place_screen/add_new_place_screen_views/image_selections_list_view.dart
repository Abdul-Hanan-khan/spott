import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spott/translations/codegen_loader.g.dart';

class ImageSelectionsListView extends StatefulWidget {
  final Function(List<Uint8List> _images) _onImageSelection;
  const ImageSelectionsListView(this._onImageSelection, {Key? key})
      : super(key: key);

  @override
  _ImageSelectionState createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelectionsListView> {
  final List<Uint8List> _images = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => _buildImageSelection(
          _images.length > index ? _images[index] : null,
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 20,
        ),
      ),
    );
  }

  Widget _buildImageSelection(Uint8List? _image) => Container(
        width: 100,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey4,
          borderRadius: BorderRadius.circular(20),
          image: _image != null
              ? DecorationImage(image: MemoryImage(_image), fit: BoxFit.cover)
              : null,
          boxShadow: _image != null
              ? [
                  const BoxShadow(
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ]
              : null,
        ),
        child: _image != null
            ? InkWell(
                onTap: () {
                  setState(() {
                    _images.remove(_image);
                  });
                },
                child: const SizedBox(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              )
            : GestureDetector(
                onTap: _pickImage,
                child:
                    Container(width: 100, height: 100, child: Icon(Icons.add)),
              ),
      );

  Future _pickImage() async {
    if (_images.length < 3) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _images.add(await pickedFile.readAsBytes());
        setState(() {});
        widget._onImageSelection(_images);
      } else {
        debugPrint('No image selected.');
      }
    }
  }
}
