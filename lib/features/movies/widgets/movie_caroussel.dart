import 'package:flutter/material.dart';
import '../data/dummy_data.dart'; // contains upcomingTrailers list

class TrailerCarousel extends StatefulWidget {
  const TrailerCarousel({super.key});

  @override
  State<TrailerCarousel> createState() => _TrailerCarouselState();
}

class _TrailerCarouselState extends State<TrailerCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_controller.hasClients && mounted) {
        int nextPage = (_currentIndex + 1) % upcomingTrailersList.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() => _currentIndex = nextPage);
        _startAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: upcomingTrailersList.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final trailer = upcomingTrailersList[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  trailer.image,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(upcomingTrailersList .length, (index) {
            bool isActive = _currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: isActive ? 24 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: isActive ? theme.colorScheme.primary : Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
        ),
      ],
    );
  }
}
