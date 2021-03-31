import 'dart:io';

import 'package:doctor/values/AppSetings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

enum MediaSource { CAMERA, GALLERY }

class MediaPicker {
  MediaSource _mediaSource;

  MediaPicker(this._mediaSource);

  getImage(context, inner(File imageFile), {isCroping = false}) async {
    try {
      File imageFile;
      if (_mediaSource == MediaSource.GALLERY) {
        imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 2000,maxWidth: 2000);
      } else if (_mediaSource == MediaSource.CAMERA) {
        imageFile = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 2000,maxWidth: 2000);
      }

      if (imageFile!=null && isCroping) {
        imageFile =
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ImageCroping(imageFile);
        }));

      }

      inner(imageFile);

    } catch (e) {
      print(e);
    }
  }
}

class ImageCroping extends StatefulWidget {
  File _sample;

  ImageCroping(this._sample);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageCropWidget();
  }
}

class ImageCropWidget extends State<ImageCroping> {
  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.black,
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: _buildCroppingImage(),
      ),
    );
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(widget._sample, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "crop",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: AppColors.white),
                ),
                onPressed: () => _cropImage(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: widget._sample,
      preferredSize: (2000 / scale).round(),
    );
//
    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    Navigator.of(context).pop(file);
  }
}
