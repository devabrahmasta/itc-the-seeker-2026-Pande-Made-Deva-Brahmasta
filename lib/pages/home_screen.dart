import 'package:flutter/material.dart';
import 'package:itc_directory/data/division_data.dart';
import 'package:itc_directory/data/user_data.dart';
import 'package:itc_directory/models/user_model.dart';
import 'package:itc_directory/pages/widgets/circle_widget.dart';
import 'package:itc_directory/providers/member_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final chairperson = context.select<MemberProvider, UserModel>(
      (p) => p.chairperson,
    );

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo_itc.png',
              height: 40,
              fit: BoxFit.cover,
            ),
            Text('ITCLUB'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    top: -50,
                    right: -80,
                    child: Circle(dimension: 250),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -30,
                    child: Circle(dimension: 150),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Information Technology Club',
                            style: textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Kelompok Studi ITC UPN "Veteran" Yogyakarta merupakan wadah pengembangan kompetensi mahasiswa',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Summmary
                  Row(
                    children: [
                      Expanded(
                        child: _CardStats(
                          title: dummyPengurus.length.toString(),
                          label: 'Anggota',
                        ),
                      ),
                      Expanded(
                        child: _CardStats(
                          title: dummyDivision.length.toString(),
                          label: 'Divisi',
                        ),
                      ),
                      Expanded(
                        child: _CardStats(title: '2026', label: 'Periode'),
                      ),
                    ],
                  ),

                  // Profile Chairperson
                  SizedBox(height: 12),
                  _header(context, 'Ketua ITC'),
                  SizedBox(height: 6),
                  _ProfileCard(data: chairperson),

                  // Divisoin Card
                  SizedBox(height: 12),
                  _header(context, 'Divisi'),
                  SizedBox(height: 6),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dummyDivision.length,
                    itemBuilder: (context, index) {
                      final data = dummyDivision[index];

                      return DivisionCard(
                        textTheme: textTheme,
                        dataDivision: data,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}


class DivisionCard extends StatelessWidget {
  const DivisionCard({
    super.key,
    required this.textTheme,
    required this.dataDivision,
  });

  final TextTheme textTheme;
  final Map<String, dynamic> dataDivision;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Image.network(
                dataDivision['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(83, 21, 61, 33),
                        Color(0xFF153D21),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      dataDivision['name'],
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${dataDivision['member']} anggota",
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Text(
                      dataDivision['desc'],
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardStats extends StatelessWidget {
  final String title;
  final String label;

  const _CardStats({required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              title,
              style: textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.data});

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        _buildBanner(colorScheme),
        Positioned(top: 80, left: 0, right: 0, child: _buildCard()),
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300)
                  ),
                  child: Image.asset(data.image, fit: BoxFit.cover),
                ),
                const SizedBox(height: 12),
                Text(data.name, style: textTheme.bodyLarge),
                Text(data.position, style: textTheme.bodyMedium),
                const SizedBox(height: 10),
                Chip(
                  label: Text(data.period, style: textTheme.labelMedium),
                  shape: const StadiumBorder(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(ColorScheme colorScheme) => SizedBox(
    height: 120,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1542435503-956c469947f6?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromARGB(83, 21, 61, 33),
                  const Color(0xFF153D21),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildCard() => Container(
    height: 170,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.grey.shade200, width: 1.5),
    ),
  );
}
