/// chat_box - manangement_user_avatar
/// Created by xhz on 30/05/2022
import 'package:chat_box/controller/account/account_controller.dart';
import 'package:chat_box/utils/toast.dart';
import 'package:flutter/material.dart';
import '../../model/account.dart';
import 'avatar.dart';
import '../dialog/more_action.dart';

class ManagementUserAvatar extends UserAvatar {
  const ManagementUserAvatar({Key? key, required Account account, void Function(BuildContext)? onSuccessfullyChanged})
      : super(key: key, account: account, onSuccessfullyChanged: onSuccessfullyChanged);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (detail) {
        Navigator.push(
            context,
            RawDialogRoute(
                barrierColor: Colors.transparent,
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, animation, ___) => Stack(
                      children: [
                        MoreActionsPopUpView(
                            animation: CurvedAnimation(parent: animation, curve: Curves.ease),
                            actions: [
                              Pair('Set Main', () {
                                AccountController.shared.changeMainAccount(account.id);
                                onSuccessfullyChanged?.call(_);
                              }),
                              Pair('Delete', () {
                                AccountController.shared.removeAccount(account.id);
                                onSuccessfullyChanged?.call(_);
                              }),
                            ],
                            preferredPosition: detail.globalPosition),
                      ],
                    )));
      },
      child: super.build(context),
    );
  }
}
