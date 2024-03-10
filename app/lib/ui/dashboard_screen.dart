import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_nexus/api/wishes_service.dart';
import 'package:helping_nexus/ui/components/custom_card_wrapper.dart';

import 'components/custom_app_bar.dart';
import 'components/swipe_card.dart';


class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends ConsumerState<DashboardScreen> {
  final WishesService _wishesService = WishesService();
  final CardSwiperController _swipeController = CardSwiperController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Dashboard', context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/screens_background_grey.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildSwiper(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomCardWrapper(
                    child: GestureDetector(
                      onTap: () =>
                          _swipeController.swipe(CardSwiperDirection.left),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.green,
                        size: 60,
                      ),
                    ),
                  ),
                  CustomCardWrapper(
                    child: GestureDetector(
                      onTap: () =>
                          _swipeController.swipe(CardSwiperDirection.right),
                      child: const Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
  
  _buildSwiper() {
    return FutureBuilder(
      future: _wishesService.getNewWishes(userId: '65ed8fd2fed34ccf99555e40'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return const Text('Error');
        }
        print(snapshot.data);

        if (snapshot.data.isEmpty) {
          return const Text('No wishes found');
        }

        final cards = snapshot.data.map(DashboardCard.new).toList();

        return Flexible(
          child: CardSwiper(
            controller: _swipeController,
            cardsCount: cards.length,
            onSwipe: _onSwipe,
            onUndo: _onUndo,
            // isLoop: false,
            allowedSwipeDirection: const AllowedSwipeDirection.only(
              right: true,
              left: true,
            ),
            numberOfCardsDisplayed: 2,
            backCardOffset: const Offset(-10, 0),
            cardBuilder: (
                context,
                index,
                horizontalThresholdPercentage,
                verticalThresholdPercentage,
                ) =>
            cards[index],
          ),
        );
      }
    );
  }
}