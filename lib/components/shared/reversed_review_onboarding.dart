import 'package:booqs_mobile/consts/images.dart';
import 'package:flutter/material.dart';

class FullScreenImageDialog extends StatelessWidget {
  final String imageUrl;
  const FullScreenImageDialog({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: InteractiveViewer(
          child: Center(
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}

class ReversedReviewOnboarding extends StatefulWidget {
  final List<Map<String, String>>? pages;
  const ReversedReviewOnboarding({super.key, this.pages});

  @override
  State<ReversedReviewOnboarding> createState() =>
      _ReversedReviewOnboardingState();
}

class _ReversedReviewOnboardingState extends State<ReversedReviewOnboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> get _pages =>
      widget.pages ??
      [
        {
          'title': '意味を覚える',
          'description':
              '「意味を覚える」ボタンを押すことで、後日、復習として「単語から意味を答える」問題を出題します。\n単語を読む力や聞く力を鍛えたい方におすすめです。',
          'image': '$onboardingImagesUrl/word_review_onboarding_1.png',
        },
        {
          'title': '単語を覚える',
          'description':
              '「単語を覚える」ボタンを押すことで、後日、復習として「意味から見出し語を答える」問題を出題します。\n単語を話す力や書く力を鍛えたい方におすすめです。',
          'image': '$onboardingImagesUrl/word_review_onboarding_2.png',
        },
      ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double dialogWidth = screenSize.width * 0.98;
    final double dialogHeight = screenSize.height * 0.92;
    final double imageMaxHeight = dialogHeight * 0.45;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: (screenSize.width - dialogWidth) / 2,
        vertical: (screenSize.height - dialogHeight) / 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _pages[index]['title']!,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _pages[index]['description']!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => FullScreenImageDialog(
                                  imageUrl: _pages[index]['image']!),
                            );
                          },
                          child: Image.network(
                            _pages[index]['image']!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: imageMaxHeight,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error_outline, size: 50),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  TextButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('前へ'),
                  )
                else
                  const SizedBox(width: 80),
                if (_currentPage < _pages.length - 1)
                  TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('次へ'),
                  )
                else
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('完了'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
