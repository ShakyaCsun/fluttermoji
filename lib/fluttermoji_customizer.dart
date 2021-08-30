import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'fluttermoji_assets/fluttermojimodel.dart';
import 'fluttermoji_controller.dart';

/// This widget provides a UI for customizing the Fluttermoji
///
/// Accepts a [outerTextTitle] which defaults to "Customize:"
///
/// Accepts an optional [scaffoldHeight] and [scaffoldWidth].
/// When using in landscape mode, it is advised to pass a [scaffoldWidth] to the widget
///
/// Adapts to the enclosing MaterialApp's dark theme settings
///
/// It is advised that a [FluttermojiCircleAvatar] also be present in the same page.
class FluttermojiCustomizer extends StatefulWidget {
  final String outerTitleText;
  final double scaffoldHeight;
  final double scaffoldWidth;
  const FluttermojiCustomizer({
    Key? key,
    this.outerTitleText = 'Customize :',
    this.scaffoldHeight = 0.0,
    this.scaffoldWidth = 0.0,
  }) : super(key: key);

  @override
  _FluttermojiCustomizerState createState() => _FluttermojiCustomizerState();
}

class _FluttermojiCustomizerState extends State<FluttermojiCustomizer>
    with SingleTickerProviderStateMixin {
  late FluttermojiController fluttermojiController;
  late TabController tabController;
  double heightFactor = 0.4;
  double widthFactor = 0.95;

  @override
  void initState() {
    super.initState();
    FluttermojiController _fluttermojiController;
    Get.put(FluttermojiController());
    _fluttermojiController = Get.find<FluttermojiController>();
    setState(() {
      tabController = TabController(length: 11, vsync: this);
      fluttermojiController = _fluttermojiController;
    });
  }

  @override
  void dispose() {
    // This ensures that unsaved edits are reverted
    fluttermojiController.restoreState();
    super.dispose();
  }

  /// Widget that renders an expanded layout for customization
  /// Accepts a [cardTitle] and a [attributes].
  ///
  /// [attribute] is an object with the fields attributeName and attributeKey
  Widget expandedCard({
    required String cardTitle,
    required List<ExpandedFluttermojiCardItem> attributes,
  }) {
    final size = MediaQuery.of(context).size;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = (!isDarkMode) ? Colors.grey[600] : Colors.white;
    //final double mediumfont = size.height * 0.038;
    final attributeRows = <Widget>[];
    final navbarWidgets = <Widget>[];
    final _appbarcolor = (!isDarkMode) ? Colors.white : Colors.grey[600];
    final _bgcolor = (!isDarkMode) ? const Color(0xFFF1F1F1) : Colors.grey[800];

    for (final attribute in attributes) {
      if (!fluttermojiController.selectedIndexes.containsKey(attribute.key)) {
        fluttermojiController.selectedIndexes[attribute.key] = 0;
      }
      final attributeListLength =
          fluttermojiProperties[attribute.key!]!.property!.length;
      var gridCrossAxisCount = 4;
      final int? i =
          fluttermojiController.selectedIndexes[attribute.key] as int?;
      if (attributeListLength < 12) {
        gridCrossAxisCount = 3;
      } else if (attributeListLength < 9) {
        gridCrossAxisCount = 2;
      }
      final Widget bottomNavWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
        child: SvgPicture.asset(
          attribute.iconAsset!,
          package: 'fluttermoji',
          height: (attribute.iconsize == 0)
              ? widget.scaffoldHeight > 0
                  ? widget.scaffoldHeight / heightFactor * 0.03
                  : size.height * 0.03
              : attribute.iconsize,
          color: iconColor,
          semanticsLabel: attribute.title,
        ),
      );

      final Widget _row = Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: _appbarcolor,
              child: Center(
                child: Text(
                  attribute.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.scaffoldHeight > 0
                        ? widget.scaffoldHeight / heightFactor * 0.024
                        : size.height * 0.024,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 11,
            // height: size.height*0.25,
            child: GridView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: attributeListLength,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCrossAxisCount,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == i) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Colors.green,
                        width: 3.0,
                      ),
                    ),
                    child: SvgPicture.string(
                      fluttermojiController.getComponentSVG(attribute.key, i),
                      height: 20,
                      semanticsLabel: "Your Fluttermoji",
                      placeholderBuilder: (context) => const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                  );
                }

                return InkWell(
                  onTap: () {
                    fluttermojiController.selectedIndexes[attribute.key] =
                        index;
                    fluttermojiController.updatePreview();
                    setState(() {});
                  },
                  child: SvgPicture.string(
                    fluttermojiController.getComponentSVG(attribute.key, index),
                    height: 20,
                    semanticsLabel: 'Your Fluttermoji',
                    placeholderBuilder: (context) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
      attributeRows.add(_row);
      navbarWidgets.add(bottomNavWidget);
    }

    return Stack(
      children: [
        Align(
          child: Container(
            width: widget.scaffoldWidth > 0
                ? widget.scaffoldWidth * widthFactor
                : size.width * widthFactor,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: DefaultTabController(
              length: attributeRows.length,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Scaffold(
                  key: const ValueKey('FMojiCustomizer'),
                  backgroundColor: _bgcolor,
                  body: TabBarView(
                    physics: const ClampingScrollPhysics(),
                    controller: tabController,
                    children: attributeRows,
                  ),
                  bottomNavigationBar: Container(
                    color: _appbarcolor, //Colors.grey[400],
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      labelPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      indicatorColor: Colors.blue,
                      indicatorPadding: const EdgeInsets.all(2),
                      tabs: navbarWidgets,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.9, -1),
          child: Visibility(
            visible: !(tabController.length == tabController.index + 1),
            child: IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
                size: widget.scaffoldHeight > 0
                    ? widget.scaffoldHeight / heightFactor * 0.025
                    : size.height * 0.025,
              ),
              onPressed: () {
                final _currentIndex = tabController.index;
                tabController.animateTo(
                  _currentIndex < tabController.length
                      ? _currentIndex + 1
                      : _currentIndex,
                );
                setState(() {});
              },
            ),
          ),
        ),
        Align(
          alignment: const Alignment(-0.9, -1),
          child: Visibility(
            visible: !(tabController.index == 0),
            child: IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.arrow_back_ios,
                color: iconColor,
                size: widget.scaffoldHeight > 0
                    ? widget.scaffoldHeight / heightFactor * 0.025
                    : size.height * 0.025,
              ),
              onPressed: () {
                final int _currentIndex = tabController.index;
                tabController.animateTo(
                  _currentIndex < tabController.length
                      ? _currentIndex - 1
                      : _currentIndex,
                );
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color? iconColor = (!isDarkMode) ? Colors.grey[700] : Colors.white;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.outerTitleText,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: widget.scaffoldHeight > 0
                      ? widget.scaffoldHeight / heightFactor * 0.03
                      : size.height * 0.03,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  fluttermojiController.setFluttermoji();
                  setState(() {});
                },
                icon: Icon(
                  Icons.save,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.scaffoldHeight > 0
              ? widget.scaffoldHeight
              : size.height * heightFactor,
          width: widget.scaffoldWidth > 0 ? widget.scaffoldWidth : size.width,
          child: expandedCard(
            cardTitle: "Customize",
            attributes: [
              /*  ExpandedFluttermojiCardItem(
                        iconAsset: "attributeicons/hair.svg",
                        title: "Fluttermoji Style",
                        key: "style"), */
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/hair.svg",
                title: "Hairstyle",
                key: "topType",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/haircolor.svg",
                title: "Hair Colour",
                key: "hairColor",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/beard.svg",
                title: "Facial Hair",
                key: "facialHairType",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/beardcolor.svg",
                title: "Facial Hair Colour",
                key: "facialHairColor",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/outfit.svg",
                title: "Outfit",
                key: "clotheType",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/outfitcolor.svg",
                title: "Outfit Colour",
                key: "clotheColor",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/eyes.svg",
                title: "Eyes",
                key: "eyeType",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/eyebrow.svg",
                title: "Eyebrows",
                key: "eyebrowType",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/mouth.svg",
                title: "Mouth",
                key: "mouthType",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/skin.svg",
                title: "Skin",
                key: "skinColor",
              ),
              ExpandedFluttermojiCardItem(
                iconAsset: "attributeicons/accessories.svg",
                title: "Glasses",
                key: "accessoriesType",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
