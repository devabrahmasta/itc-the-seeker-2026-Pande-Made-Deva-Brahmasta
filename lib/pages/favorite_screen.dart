import 'package:flutter/material.dart';
import 'package:itc_directory/models/user_model.dart';
import 'package:itc_directory/pages/card_widget.dart';
import 'package:itc_directory/providers/member_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.select<MemberProvider, List<UserModel>>(
      (p) => p.favoriteMembers,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Pengurus Favotire')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return StructureCard(member: favorites[index], isTiles: true);
          },
        ),
      ),
    );
  }
}
