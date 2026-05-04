import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:itc_directory/models/user_model.dart';
import 'package:itc_directory/providers/member_provider.dart';

class DetailScreen extends StatelessWidget {
  final UserModel member;

  const DetailScreen({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isFav = context.watch<MemberProvider>().isFavorite(member.name);

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pengurus',
              style: textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            Text(
              'Informasi & kontak',
              style: textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.redAccent : Colors.white,
            ),
            onPressed: () async {
              final provider = context.read<MemberProvider>();
              await provider.toggleFavorite(member.name);

              if (context.mounted) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(provider.message),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomCenter,
                colors: [
                  Color(0xFF153D21),
                  Color(0xFF153D21),
                  Color.fromARGB(255, 27, 85, 45),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: -60,
                  right: -90,
                  child: Circle(dimension: 250, color: Colors.white10),
                ),
                Positioned(
                  top: 10,
                  left: -50,
                  child: Circle(dimension: 150, color: Colors.white10),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.asset(member.image, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        member.name,
                        style: textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          member.position,
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              decoration: BoxDecoration(color: colorScheme.surfaceContainerLow),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildInfoRow(
                              'Jabatan',
                              member.position,
                              textTheme,
                            ),
                            const Divider(height: 24),
                            _buildInfoRow(
                              'Divisi / Asal',
                              member.division,
                              textTheme,
                            ),
                            const Divider(height: 24),
                            _buildInfoRow('Periode', member.period, textTheme),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TUGAS & TANGGUNG JAWAB',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              member.jobDesc,
                              style: textTheme.bodyMedium?.copyWith(
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'KONTAK',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildContactCard(
                          'WhatsApp',
                          member.wa,
                          HugeIcons.strokeRoundedWhatsapp,
                          isPrimary: true,
                        ),
                        _buildContactCard(
                          'LINE',
                          member.line,
                          HugeIcons.strokeRoundedLine,
                        ),
                        _buildContactCard(
                          'Instagram',
                          member.ig,
                          HugeIcons.strokeRoundedInstagram,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textTheme.bodyMedium),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildContactCard(
    String title,
    String subtitle,
    List<List<dynamic>> icon, {
    bool isPrimary = false,
  }) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              HugeIcon(icon: icon, color: const Color(0xFF153D21), size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey, fontSize: 10),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key, required this.dimension, required this.color});

  final double dimension;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
