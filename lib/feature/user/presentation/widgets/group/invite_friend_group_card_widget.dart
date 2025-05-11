import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class InviteFriendGroupCardWidget extends StatelessWidget {
  final UserEntity user;
  final void Function(String) onPressed;
  final bool isActionInvite;

  const InviteFriendGroupCardWidget({
    super.key,
    required this.user,
    required this.onPressed,
    this.isActionInvite = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppAvatarWidget(imagePath: user.profilePictureUrl, size: 40),
      title: Text(user.username),
      trailing: SizedBox(
        width: 80,
        height: 40,
        child: AppButtonWidget(
          onPressed: () => onPressed(user.id),
          title: isActionInvite ? "Đã mời" : "Mời",
          color: isActionInvite ? AppColors.black : AppColors.white,
          bgColor: isActionInvite ? AppColors.bgGray : AppColors.bgPink,
        ),
      ),
    );
  }
}
