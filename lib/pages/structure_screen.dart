import 'package:flutter/material.dart';
import 'package:itc_directory/pages/widgets/card_widget.dart';
import 'package:provider/provider.dart';
import 'package:itc_directory/providers/member_provider.dart';
import 'package:itc_directory/models/user_model.dart';

class StructureScreen extends StatelessWidget {
  const StructureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final intiMembers = context.select<MemberProvider, List<UserModel>>(
      (p) => p.intiMembers,
    );
    final devMap = context.select<MemberProvider, Map<String, List<UserModel>>>(
      (p) => p.devMembersByDivision,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Struktur ITC')),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Container(
                  width: 5,
                  height: 150 * (intiMembers.length.toDouble() + devMap.length),
                  decoration: BoxDecoration(color: colorScheme.primary),
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                _SectionHeader(title: 'Pengurus Inti'),
                const SizedBox(height: 8),
                ...intiMembers.map(
                  (e) => StructureCard(member: e, isTiles: false),
                ),

                _SectionHeader(title: 'Divisi Development'),
                const SizedBox(height: 8),
                ...devMap.entries.map(
                  (e) => _DevTiles(divisionName: e.key, members: e.value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Title
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}

// Widget Development Tiles
class _DevTiles extends StatelessWidget {
  const _DevTiles({required this.divisionName, required this.members});

  final String divisionName;
  final List<UserModel> members;

  @override
  Widget build(BuildContext context) {
    final inkadiv = members.where((e) => e.position.contains('Ketua'));
    final anggota = members.where((e) => e.position == 'Anggota');

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: ExpansionTile(
          backgroundColor: Colors.white,
          title: Text(
            divisionName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (inkadiv.isNotEmpty) ...[
                    Text(
                      'Inkadiv',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    ...inkadiv.map(
                      (e) => StructureCard(member: e, isTiles: true),
                    ),
                  ],
                  if (anggota.isNotEmpty) ...[
                    Text(
                      'Anggota',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    ...anggota.map(
                      (e) => StructureCard(member: e, isTiles: true),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
