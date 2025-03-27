import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/bloc/home_bloc.dart';
import '../../logic/state/home_state.dart';

class HomeScreenBanner extends StatefulWidget {
  const HomeScreenBanner({super.key});

  @override
  State<HomeScreenBanner> createState() => _HomeScreenBannerState();
}

class _HomeScreenBannerState extends State<HomeScreenBanner> {
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomeError) {
          return Center(
            child: Text('Failed to load data'),
          );
        }

        if (state is HomeLoaded) {
          final images = state.sliders.map((slider) => slider.image).toList();

          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 222.h,
                child: PageView.builder(
                  itemCount: images.length,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(11),
                        ),
                      ),
                      // child: Image.asset(images[index],fit: BoxFit.cover,),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(images.length, activePage),
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  List<Widget> indicators(imagesLength, currectIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color.fromRGBO(193, 193, 193, 1)),
          color:
              currectIndex == index
                  ? Color.fromRGBO(193, 193, 193, 1)
                  : Colors.white,
          shape: BoxShape.circle,
        ),
      );
    });
  }
}
