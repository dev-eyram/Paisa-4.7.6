import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sika_purse/src/core/common.dart';

import '../../../app/routes.dart';
import '../../widgets/sika_purse_icon_title.dart';
import '../../widgets/sika_purse_search_bar.dart';
import '../../widgets/sika_purse_user_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';
import 'home_page.dart';

class HomeDesktopPage extends StatelessWidget {
  const HomeDesktopPage({
    super.key,
    required this.floatingActionButton,
    required this.destinations,
  });

  final List<Destination> destinations;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SikaPurseIconTitle(),
        ),
        leadingWidth: 300,
        title: const SikaPurseSearchBar(),
        actions: const [SikaPurseUserWidget()],
      ),
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return NavigationDrawer(
                elevation: 0,
                selectedIndex: homeBloc.selectedIndex,
                onDestinationSelected: (index) {
                  homeBloc.add(CurrentIndexEvent(index));
                },
                children: [
                  ...destinations
                      .map((e) => NavigationDrawerDestination(
                            icon: e.icon,
                            selectedIcon: e.selectedIcon,
                            label: Text(e.label),
                          ))
                      .toList(),
                  const Divider(),
                  ListTile(
                    onTap: () => context.pushNamed(settingsName),
                    leading: Icon(
                      Icons.settings,
                      color: context.primary,
                    ),
                    title: Text(
                      context.loc.settings,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        textStyle: context.bodyLarge,
                        color: context.onBackground,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: SafeArea(
              child: ContentWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
