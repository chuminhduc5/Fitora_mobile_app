import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class _PopoverMenu extends StatefulWidget {
  @override
  State<_PopoverMenu> createState() => _State();
}

class _State extends State<_PopoverMenu> with SingleTickerProviderStateMixin {
  late FPopoverController controller;
  late FRadioSelectGroupController<String> groupController;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
    groupController = FRadioSelectGroupController<String>();
  }

  @override
  Widget build(BuildContext context) => FHeader(
    title: const Text('Edit Notes'),
    actions: [
      FPopoverMenu(
        popoverController: controller,
        menuAnchor: Alignment.topRight,
        childAnchor: Alignment.bottomRight,
        menu: [
          FTileGroup(
            children: [
              FTile(
                prefixIcon: FIcon(FAssets.icons.user),
                title: const Text('Personalization'),
                onPress: () {},
              ),
              FTile(
                prefixIcon: FIcon(FAssets.icons.paperclip),
                title: const Text('Add attachments'),
                onPress: () {},
              ),
              FTile(
                prefixIcon: FIcon(FAssets.icons.qrCode),
                title: const Text('Scan Document'),
                onPress: () {},
              ),
            ],
          ),
          FTileGroup(
            children: [
              FTile(
                prefixIcon: FIcon(FAssets.icons.list),
                title: const Text('List View'),
                onPress: () {},
              ),
              FTile(
                prefixIcon: FIcon(FAssets.icons.layoutGrid),
                title: const Text('Grid View'),
                onPress: () {},
              ),
            ],
          ),
        ],
        child: FHeaderAction(
          icon: FIcon(FAssets.icons.ellipsis),
          onPress: controller.toggle,
        ),
      ),
    ],
  );

  @override
  void dispose() {
    controller.dispose();
    groupController.dispose();
    super.dispose();
  }
}