import 'package:flutter/material.dart';
import 'package:new_app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer({super.key, required this.onProfileTap, required this.onSignOut,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
            Icons.person,
            color: Colors.indigo,
            size: 64,
            ),
          ),

          //home
          MyListTile(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.pop(context),
          ), 
          //profile
          MyListTile(
              icon: Icons.person,
              text: 'My Profile',
              onTap: onProfileTap,
          ),
          //logout
          MyListTile(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: onSignOut,
          ),
        ]
      )
    );
  }
}
