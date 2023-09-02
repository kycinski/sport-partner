import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/edit_profile_controller.dart';

class EditPhoto extends StatelessWidget {
  const EditPhoto({super.key});

  Image _buildImage(EditProfileController editProfileController) {
    const imageSize = 120.0;
    final pickedImage = editProfileController.pickedImage;
    final profilePhotoUrl = editProfileController.profileImageUrl;
    if (pickedImage != null) {
      return Image.file(
        pickedImage,
        height: imageSize,
        width: imageSize,
        fit: BoxFit.cover,
      );
    } else if (profilePhotoUrl != null) {
      return Image.network(
        profilePhotoUrl,
        height: imageSize,
        width: imageSize,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/profile_picture.jpeg',
        height: imageSize,
        width: imageSize,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final editProfileController = context.watch<EditProfileController>();
    return Stack(
      children: [
        ClipOval(
          child: _buildImage(editProfileController),
        ),
        if (editProfileController.profileImageUrl != null || editProfileController.pickedImage != null)
          Positioned(
            bottom: 0,
            left: 0,
            child: GestureDetector(
              onTap: () async => await editProfileController.removeProfileImage(),
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async => await editProfileController.editProfileImage(),
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(
                editProfileController.profileImageUrl == null && editProfileController.pickedImage == null
                    ? Icons.add
                    : Icons.edit,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
