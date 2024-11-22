import 'package:codehub/managers/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.user,super.key,});
  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget buildDrawer(){
    User user = widget.user;
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: user.image.isNotEmpty ? NetworkImage(user.image) : const AssetImage('assets/images/codehub.png'),
            ),
              accountName: Text(user.name),
              accountEmail: Text(user.mail)
          ),
          const Expanded(
              child: SizedBox()
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context){
                    final authManager = Provider.of<AuthManager>(context,listen: true);
                    return AlertDialog(
                      title: const Text('Sign Out Alert'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Are you sure to sign out?'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: const Text('No')
                              ),
                              TextButton(
                                  onPressed: (){
                                    authManager.signOut();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Yes')
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
              );
            },
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        title: const Text('Code Hub'),
        actions: [],
      ),
    );
  }
}
