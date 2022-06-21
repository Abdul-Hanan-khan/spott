import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spott/ui/ui_components/loading_animation.dart';

class CoverImagePickerView extends StatefulWidget {
  final Function(Uint8List? _image)? onImageSelection;
  final String? imageUrl;
  const CoverImagePickerView({Key? key, this.imageUrl, this.onImageSelection})
      : super(key: key);

  @override
  _CoverImagePickerViewState createState() => _CoverImagePickerViewState();
}

class _CoverImagePickerViewState extends State<CoverImagePickerView> {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GestureDetector(
        onTap: _pickImage,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 150,
              child: _pickedImage != null
                  ? Image.memory(
                      _pickedImage!,
                      fit: BoxFit.cover,
                    )
                  : widget.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: widget.imageUrl!,
                          placeholder: (_, __) => const LoadingAnimation(),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            "assets/icons/no_image.svg",
                            width: 50,
                            height: 50,
                          ),
                        ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
