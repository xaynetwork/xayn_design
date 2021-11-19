import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Linden get linden => UnterDenLinden.getLinden(context);

  bool blockTrackersEnable = true;
  bool blockAdsEnable = true;

  final List<Widget> sections = [];

  @override
  void initState() {
    sections.addAll([
      const _PrivacySection(),
      const _AppLanguageSection(),
      const _IrrelevantContentSection(),
      const _AppThemeSection(),
      const _HomeLayoutSection(),
      const _GridSetupSection(),
      const _SpreadWordSection(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 42,
        ),
        itemBuilder: (context, index) => sections[index],
        itemCount: sections.length,
      );
}

class _PrivacySection extends StatefulWidget {
  const _PrivacySection({Key? key}) : super(key: key);

  @override
  _PrivacySectionState createState() => _PrivacySectionState();
}

class _PrivacySectionState extends State<_PrivacySection> {
  Linden get linden => UnterDenLinden.getLinden(context);

  bool blockTrackersEnable = true;
  bool blockAdsEnable = true;
  bool blockCookiesEnable = true;

  @override
  Widget build(BuildContext context) => SettingsSection(
        title: 'Privacy settings',
        items: [
          _getBlockTrackers(),
          _getBlockAds(),
          _getCookies(),
          _getEmptyCache(),
        ],
      );

  SettingsCardData _getBlockTrackers() {
    final tile = SettingsTileData(
      title: 'Block trackers',
      svgIconPath: linden.assets.icons.shield,
      action: SettingsTileActionSwitch(
          key: const Key('Block trackers'),
          value: blockTrackersEnable,
          onPressed: () {
            setState(() {
              blockTrackersEnable = !blockTrackersEnable;
            });
          }),
    );
    return SettingsCardData.fromTile(tile);
  }

  SettingsCardData _getBlockAds() {
    final tile = SettingsTileData(
      title: 'Block ads',
      svgIconPath: linden.assets.icons.shield,
      action: SettingsTileActionSwitch(
          key: const Key('Block ads'),
          value: blockAdsEnable,
          onPressed: () {
            setState(() {
              blockAdsEnable = !blockAdsEnable;
            });
          }),
    );

    return SettingsCardData.fromTile(tile);
  }

  SettingsCardData _getCookies() {
    final blockCookies = SettingsTileData(
      title: 'Block cookies',
      svgIconPath: linden.assets.icons.shield,
      action: SettingsTileActionSwitch(
          key: const Key('Block cookies'),
          value: blockCookiesEnable,
          onPressed: () {
            setState(() {
              blockCookiesEnable = !blockCookiesEnable;
            });
          }),
    );
    final clearCookies = SettingsTileData(
      title: 'Block cookies',
      action: SettingsTileActionIcon(
          key: const Key('clear cookies'),
          svgIconPath: linden.assets.icons.trash,
          onPressed: () {}),
    );
    return SettingsCardData.fromTiles([
      blockCookies,
      clearCookies,
    ]);
  }

  SettingsCardData _getEmptyCache() {
    final tile = SettingsTileData(
      title: 'Empty cache',
      svgIconPath: linden.assets.icons.lightening,
      action: SettingsTileActionIcon(
        key: const Key('Empty cache'),
        svgIconPath: linden.assets.icons.trash,
        onPressed: () {},
      ),
    );

    return SettingsCardData.fromTile(tile);
  }
}

class _AppLanguageSection extends StatefulWidget {
  const _AppLanguageSection({Key? key}) : super(key: key);

  @override
  _AppLanguageSectionState createState() => _AppLanguageSectionState();
}

class _AppLanguageSectionState extends State<_AppLanguageSection> {
  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  Widget build(BuildContext context) => SettingsSection(
        title: 'Your app language',
        subTitle: 'Chose the interface language',
        items: [_getBlockTrackers()],
      );

  SettingsCardData _getBlockTrackers() {
    final tile = SettingsTileData(
      title: 'Active: English',
      svgIconPath: linden.assets.icons.language,
      action: SettingsTileActionText(
        key: const Key('Active: English'),
        text: 'Edit',
        onPressed: () {},
      ),
    );
    return SettingsCardData.fromTile(tile);
  }
}

class _IrrelevantContentSection extends StatefulWidget {
  const _IrrelevantContentSection({Key? key}) : super(key: key);

  @override
  _IrrelevantContentSectionState createState() =>
      _IrrelevantContentSectionState();
}

class _IrrelevantContentSectionState extends State<_IrrelevantContentSection> {
  final String topicCovid = 'Covid';
  final String topicBlog = 'Cool people blog';
  final String topicGodzilla = 'Godzilla';

  Linden get linden => UnterDenLinden.getLinden(context);

  Map<String, bool> topics = {};

  @override
  void initState() {
    topics[topicCovid] = true;
    topics[topicBlog] = false;
    topics[topicGodzilla] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cardData = SettingsCardData([
      _getDismissedSources(),
      _getDismissedTopics(),
    ]);
    return SettingsSection(
      title: 'Content marked as irrelevant',
      items: [cardData],
    );
  }

  SettingsGroupData _getDismissedSources() {
    final tile = SettingsTileData(
      title: 'No dismissed items',
      svgIconPath: linden.assets.icons.info,
    );
    return SettingsGroupData(title: 'Sources', items: [tile]);
  }

  SettingsGroupData _getDismissedTopics() {
    final items = topics.keys.map(
      (topic) {
        final active = topics[topic] ?? false;
        final icon =
            active ? linden.assets.icons.minus : linden.assets.icons.plus;
        return SettingsTileData(
            title: topic,
            subTitle: active ? null : 'Was just deleted from this list',
            action: SettingsTileActionCircle(
                key: Key(topic),
                isActive: active,
                svgIconPath: icon,
                onPressed: () {
                  setState(() {
                    topics[topic] = !active;
                  });
                }));
      },
    ).toList();
    return SettingsGroupData(title: 'Topics', items: items);
  }
}

class _AppThemeSection extends StatefulWidget {
  const _AppThemeSection({Key? key}) : super(key: key);

  @override
  _AppThemeSectionState createState() => _AppThemeSectionState();
}

enum _AppTheme {
  system,
  light,
  dark,
}

class _AppThemeSectionState extends State<_AppThemeSection> {
  Linden get linden => UnterDenLinden.getLinden(context);

  _AppTheme currentTheme = _AppTheme.system;

  @override
  Widget build(BuildContext context) {
    final selectable = SettingsSelectable.icons(
      items: _AppTheme.values.map(_getItem).toList(),
    );
    return SettingsSection.custom(
      title: 'Your app theme',
      child: selectable,
    );
  }

  SettingsSelectableData _getItem(_AppTheme theme) {
    late final String title;
    late final String icon;

    switch (theme) {
      case _AppTheme.system:
        title = 'System default';
        icon = linden.assets.icons.moonAndSun;
        break;
      case _AppTheme.light:
        title = 'Light mode';
        icon = linden.assets.icons.sun;
        break;
      case _AppTheme.dark:
        title = 'Dark mode';
        icon = linden.assets.icons.moon;
        break;
    }

    return SettingsSelectableData(
        key: Key(theme.toString()),
        title: title,
        svgIconPath: icon,
        isSelected: currentTheme == theme,
        onPressed: () {
          setState(() {
            currentTheme = theme;
          });
        });
  }
}

class _HomeLayoutSection extends StatefulWidget {
  const _HomeLayoutSection({Key? key}) : super(key: key);

  @override
  _HomeLayoutSectionState createState() => _HomeLayoutSectionState();
}

enum _HomeLayout {
  combo,
  searchBar,
  newsFeed,
}

class _HomeLayoutSectionState extends State<_HomeLayoutSection> {
  Linden get linden => UnterDenLinden.getLinden(context);

  _HomeLayout currentLayout = _HomeLayout.combo;

  @override
  Widget build(BuildContext context) {
    final selectable = SettingsSelectable.graphics(
      items: _HomeLayout.values.map(_getItem).toList(),
    );
    return SettingsSection.custom(
      title: 'Your Home Screen Setup',
      subTitle: 'What is displayed',
      child: selectable,
    );
  }

  SettingsSelectableData _getItem(_HomeLayout layout) {
    late final String title;
    late final String graphic;

    switch (layout) {
      case _HomeLayout.combo:
        title = 'Search bar &\nNews Feed';
        graphic = linden.assets.graphics.searchNews;
        break;
      case _HomeLayout.searchBar:
        title = 'Only\nSearch Bar';
        graphic = linden.assets.graphics.searchOnly;
        break;
      case _HomeLayout.newsFeed:
        title = 'Only\nNews Feed';
        graphic = linden.assets.graphics.newsOnly;
        break;
    }

    return SettingsSelectableData(
        key: Key(layout.toString()),
        title: title,
        svgIconPath: graphic,
        isSelected: currentLayout == layout,
        onPressed: () {
          setState(() {
            currentLayout = layout;
          });
        });
  }
}

class _GridSetupSection extends StatefulWidget {
  const _GridSetupSection({Key? key}) : super(key: key);

  @override
  _GridSetupSectionState createState() => _GridSetupSectionState();
}

enum _GridSetup {
  grid,
  list,
}

class _GridSetupSectionState extends State<_GridSetupSection> {
  Linden get linden => UnterDenLinden.getLinden(context);

  _GridSetup currentSetup = _GridSetup.grid;

  @override
  Widget build(BuildContext context) {
    final selectable = SettingsSelectable.graphics(
      items: _GridSetup.values.map(_getItem).toList(),
    );
    return SettingsSection.custom(
      title: 'Grid setup',
      subTitle: 'How your results should be displayed',
      child: selectable,
    );
  }

  SettingsSelectableData _getItem(_GridSetup layout) {
    late final String title;
    late final String graphic;

    switch (layout) {
      case _GridSetup.grid:
        title = 'Grid view';
        graphic = linden.assets.graphics.gridView;
        break;
      case _GridSetup.list:
        title = 'List view';
        graphic = linden.assets.graphics.listView;
        break;
    }

    return SettingsSelectableData(
        key: Key(layout.toString()),
        title: title,
        svgIconPath: graphic,
        isSelected: currentSetup == layout,
        onPressed: () {
          setState(() {
            currentSetup = layout;
          });
        });
  }
}

class _SpreadWordSection extends StatelessWidget {
  const _SpreadWordSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SettingsSection.custom(
        title: 'Spread the Word',
        crossAxisAlignment: CrossAxisAlignment.center,
        child: AppRaisedButton.textWithIcon(
            onPressed: () {},
            text: 'Share with friends',
            svgIconPath: UnterDenLinden.getLinden(context).assets.icons.heart),
      );
}
