import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Padding playQuizTilePadding(ListTile tile) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 12.5, bottom: 12.5, left: 25, right: 25),
    child: tile,
  );
}

class QuizmeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const QuizmeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut().onError(
                (error, stackTrace) => print("Error in signing out, appbar"));

            // Fix for  warning of dont use buildcontext in async gaps
            if (!context.mounted) {
              return;
            }
            // Empty the stack
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
          icon: const Icon(Icons.logout_outlined),
          iconSize: 30,
        ),
      ],
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.normal),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
