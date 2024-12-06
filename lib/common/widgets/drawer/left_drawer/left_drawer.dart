import 'package:flutter/material.dart';

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
              leading: const Icon(Icons.add, size: 20,),
              title: const Text('Tạo mới', style: TextStyle(fontSize: 14),),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 15),
              leading: const CircleAvatar(
                radius: 12,
                child: Text('H', style: TextStyle(fontSize: 13),),
              ),
              title: const Text('Tất cả', style: TextStyle(fontSize: 14),),
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.star_border, size: 20,),),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 15),
              leading: const CircleAvatar(
                radius: 12,
                child: Text('H', style: TextStyle(fontSize: 13),),
              ),
              title: const Text('Tất cả', style: TextStyle(fontSize: 14),),
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.star_border, size: 20,),),
              onTap: () {},
            ),
          ],
        ),
        ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide.none,
          ),
          title: const Text('Tất cả', style: TextStyle(fontSize: 15),),
          minTileHeight: 20,
          children: <Widget>[],
        ),
      ],
    ),
  );
}
