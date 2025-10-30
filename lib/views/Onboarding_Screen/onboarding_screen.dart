import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrfinal_personalized/res/routes/routes_names.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  // Example onboarding data
  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onbarding_1.png",
      "title": "Welcome",
      "desc": "Welcome to our awesome app!",
    },
    {
      "image": "assets/images/onbarding_2.png",
      "title": "Discover",
      "desc": "Discover new features easily.",
    },
    {
      "image": "assets/images/onbarding_3.png",
      "title": "Get Started",
      "desc": "Let's get started now!",
    },
  ];

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void skip() {
    _pageController.jumpToPage(onboardingData.length - 1);
    Get.offAllNamed(RouteName.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with progress and skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${currentPage + 1}/${onboardingData.length}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: skip,
                    child: const Text("Skip", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),

            // PageView section
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return buildOnboardPage(
                    image: data["image"]!,
                    title: data["title"]!,
                    desc: data["desc"]!,
                  );
                },
              ),
            ),

            // Dot indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                    (index) => buildDot(index, currentPage),
              ),
            ),

            const SizedBox(height: 20),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentPage == 0
                      ? const SizedBox(width: 80)
                      : TextButton(
                    onPressed: previousPage,
                    child: const Text("Previous", style: TextStyle(color: Colors.grey)),
                  ),
                  currentPage == onboardingData.length - 1
                      ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: skip,
                    child: const Text("Get Started",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  )
                      : TextButton(
                    onPressed: nextPage,
                    child: const Text("Next", style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnboardPage({
    required String image,
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          const SizedBox(height: 30),
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey))
        ],
      ),
    );
  }

  Widget buildDot(int index, int currentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: currentPage == index ? 20 : 8,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blueAccent : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
