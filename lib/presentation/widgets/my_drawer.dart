import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bussiness_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/app_colors.dart';
import 'package:maps_app/presentation/widgets/my_divider.dart';
import 'package:maps_app/presentation/widgets/my_drawer_header.dart';
import 'package:maps_app/presentation/widgets/my_social_media_icons.dart';

import '../../app_router.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  Widget buildDrawerListItem({
    required IconData leadingIcon,
    required String title,
    Widget? trailling,
    Function()? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(leadingIcon, color: color ?? AppColors.blue),
      title: Text(title),
      trailing: trailling ??
          const Icon(
            Icons.arrow_right,
            color: AppColors.blue,
          ),
      onTap: onTap,
    );
  }

  _logout(context) async {
    await phoneAuthCubit.logOut();
    Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
  }

  Widget buildLogoutBlocProvider(context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => phoneAuthCubit,
      child: buildDrawerListItem(
        leadingIcon: Icons.logout,
        title: 'Logout',
        onTap: () => _logout(context),
        color: AppColors.red,
        trailling: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: MyDrawerHeader(phoneAuthCubit: phoneAuthCubit),
            ),
          ),
          buildDrawerListItem(
            leadingIcon: Icons.person,
            title: 'My Profile',
            onTap: () {},
          ),
          const MyDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          const MyDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.settings,
            title: 'Settings',
            onTap: () {},
          ),
          const MyDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.help,
            title: 'Help',
            onTap: () {},
          ),
          const MyDivider(),
          buildLogoutBlocProvider(context),
          const SizedBox(height: 200),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: Text(
              'Follow us',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 25),
          const MySocialMediaIcons(),
        ],
      ),
    );
  }
}
