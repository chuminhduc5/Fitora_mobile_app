import 'package:fitora_mobile_app/common/widgets/drawer/left_drawer/left_drawer_option.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> _option = [
  {"avatar": "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg", "title": "Tất cả", "icon": Icons.star_border},
  {"avatar": "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg", "title": "Tất cả", "icon": Icons.star_border},
  {"avatar": "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg", "title": "Tất cả", "icon": Icons.star_border},
  {"avatar": "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg", "title": "Tất cả", "icon": Icons.star_border},
];

Widget leftDrawer() {
  return Drawer(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
      side: BorderSide.none,
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide.none,
          ),
          title: const Text('Cộng đồng của bạn', style: TextStyle(fontSize: 15),),
          minTileHeight: 20,
          initiallyExpanded: true,
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.only(left: 15),
              dense: true,
              //visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.add, size: 20,),
              title: const Text('Tạo mới', style: TextStyle(fontSize: 14),),
              onTap: () {},
            ),
            //..._option.map((i) => leftDrawerOption(i['avatar'], i["icon"], i["title"], (){})),
            ListView.builder(
              itemCount: _option.length,
              itemBuilder: (BuildContext context, int index){
                final option = _option[index];
                return leftDrawerOption(option['avatar'], option['icon'], option['title'], (){});
              },
            )
          ],
        ),
        ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide.none,
          ),
          title: const Text('Tất cả', style: TextStyle(fontSize: 15),),
          minTileHeight: 20,
          children: const <Widget>[],
        ),
      ],
    ),
  );
}
