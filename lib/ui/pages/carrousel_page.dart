import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import '../../app/theme.dart';


//* Clase para gestionar la UI del Carrousel inicial
class CarrouselPage extends StatefulWidget {
  static const name = 'carrousel-page';
  

  const CarrouselPage({super.key});

  @override
  State<CarrouselPage> createState() => _CarrouselPageState();
}

class _CarrouselPageState extends State<CarrouselPage> {
  LiquidController liquidController = LiquidController();
  List<_CarrouselItem> data = [];
  int pageIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  Widget _buildDot(int index) {
    double size = pageIndex == index ? 6 : 4;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: CircleAvatar(
        radius: size,
        backgroundColor: pageIndex == index
          ? AppTheme.colorScheme.tertiary
          : AppTheme.kMoviesBlack.withOpacity(0.4),
      ),
    );
  }

  pageChangeCallback(int lpage) async {
    if(mounted) setState(() => pageIndex = lpage);
    await Future.delayed(const Duration(seconds: 3));
    int currentPage = liquidController.currentPage;
    if (lpage == currentPage && mounted) {
      if(mounted) liquidController.animateToPage(page: pageIndex + 1);
    }
  }

  _startAnimation() async {
    int startPage = liquidController.currentPage;
    await Future.delayed(const Duration(seconds: 3));
    int currentPage = liquidController.currentPage;
    if (startPage == currentPage){
      if(mounted) liquidController.animateToPage(page: pageIndex + 1);
    }
  }


  @override
  Widget build(BuildContext context) {
    data = [
      _CarrouselItem(
          AppTheme.kMoviesOrangeLight,
          "assets/images/carrousel_1.svg",
          AppLocalizations.of(context)!.carrousel_title1
        ),
        _CarrouselItem(
          AppTheme.kMoviesRedLight,
         "assets/images/carrousel_2.svg",
          AppLocalizations.of(context)!.carrousel_title2,
        ),
        _CarrouselItem(
          AppTheme.kMoviesPurpleLight,
         "assets/images/carrousel_3.svg",
          AppLocalizations.of(context)!.carrousel_title3,
        ),
        _CarrouselItem(
          AppTheme.kMoviesGreenLight,
         "assets/images/carrousel_4.svg",
          AppLocalizations.of(context)!.carrousel_title4,
        ),
    ];
    return Scaffold(
      body: LiquidSwipe.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Stack(alignment: Alignment.center, children: [
            Container(
              color: data[index].backgroundColor,
              child: SafeArea(
                bottom: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30,50,10,0),
                      child: SizedBox(
                        height: 130,
                        child: Text(
                          data[index].title,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w400),
                        ),
                      )
                    ),
                    SizedBox(
                      height: 40.h,
                      width: 40.h,
                      child: SvgPicture.asset(data[index].image),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal : 16),
                child: ElevatedButton(
                  onPressed: () => context.pushReplacement('/home/0'),
                  child: Center(
                    child:Text(
                      AppLocalizations.of(context)!.carrousel_button,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppTheme.colorScheme.primary),
                      )),
                ),
              ),
            ),
            Positioned(
              bottom: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(data.length, _buildDot),
              ),
            ),
            ]
          );
        },
        onPageChangeCallback: pageChangeCallback,
        waveType: WaveType.liquidReveal,
        liquidController: liquidController,
        enableSideReveal: false,
        enableLoop: true,
      ),
    );
  }
}

class _CarrouselItem {
  final Color backgroundColor;
  final String image;
  final String title;

  _CarrouselItem(this.backgroundColor, this.image, this.title);
}