import 'package:flutter/material.dart';
import 'package:itc_directory/models/user_model.dart';
import 'package:itc_directory/pages/detail_screen.dart';

class StructureCard extends StatelessWidget {
  const StructureCard({super.key, required this.member, required this.isTiles});

  final UserModel member;
  final bool isTiles;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(member: member),
            ),
          );
        },
        child: Padding(
          padding: isTiles
              ? EdgeInsets.only(bottom: 6)
              : EdgeInsets.only(bottom: 30),
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  // Image Placeholder
                  Container(
                    width: 70,
                    height: 70,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: member.image.isNotEmpty
                        ? Image.asset(member.image, fit: BoxFit.cover)
                        : const Icon(Icons.person, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Chip Jabatan
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              colors: [
                                colorScheme.primary,
                                colorScheme.primaryContainer,
                              ],
                            ),
                          ),
                          child: Text(
                            member.position,
                            style: textTheme.labelMedium?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Nama
                        Text(
                          member.name,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Divisi
                        Text(
                          member.division,
                          style: textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
