import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:uhl_link/config/routes/routes_consts.dart';
import 'package:uhl_link/features/home/domain/entities/feed_entity.dart';
import 'package:uhl_link/features/home/presentation/bloc/feed_page_bloc/feed_bloc.dart';
import 'package:uhl_link/features/home/presentation/widgets/feed_detail_page.dart';

class EventsPage extends StatefulWidget {
  final bool isGuest;
  final Map<String, dynamic> user;

  const EventsPage({super.key, required this.isGuest, required this.user});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<FeedItemEntity> eventItems = []; // Renamed from feedItems

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2));
    BlocProvider.of<FeedBloc>(context).add(const GetFeedItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    String porsString = dotenv.env["POR_EMAILS"] ?? "";
    List<String> pors = porsString.split(',');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          "Events",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state is FeedItemsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FeedItemsLoaded) {
                eventItems = state.items; // Renamed from feedItems
                if (eventItems.isEmpty) {
                  return Center(
                    child: Text(
                      'No events available',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                }
                return ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  primary: true,
                  itemCount: eventItems.length,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.09),
                  itemBuilder: (BuildContext context, int index) {
                    return eventItemCard(context, index); // Renamed method
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                );
              } else if (state is FeedItemsLoadingError) {
                return const Center(
                  child: Text(
                    'Failed to load events.',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is FeedItemAdded || state is FeedItemsAddingError) {
                BlocProvider.of<FeedBloc>(context)
                    .add(const GetFeedItemsEvent());
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          !widget.isGuest && pors.contains(widget.user["email"])
              ? Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton.extended(
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  UhlLinkRoutesNames.feedAddItemPage,
                  pathParameters: {"user": jsonEncode(widget.user)},
                );
              },
              label: Text(
                'Add Events',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 14),
              ),
              icon: Icon(
                Icons.add_box_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }

  Card eventItemCard(BuildContext context, int index) { // Renamed from feedItemCard
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                  items: eventItems[index] // Updated to eventItems
                      .images
                      .map((image) => ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context)
                              .cardColor
                              .withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        height: MediaQuery.of(context).size.height * 0.25,
                        errorWidget: (context, object, stacktrace) {
                          return Icon(
                            Icons.error_outline_rounded,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))
                      .toList(),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.3,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(seconds: 5),
                    enlargeCenterPage: true,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventItems[index].title, // Updated to eventItems
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                      Text(
                        eventItems[index].description.trim(), // Updated to eventItems
                        textAlign: TextAlign.start,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                      Text(
                        eventItems[index].host, // Updated to eventItems
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedDetailPage(
                                images: eventItems[index].images, // Updated to eventItems
                                host: eventItems[index].host, // Updated to eventItems
                                description: eventItems[index].description, // Updated to eventItems
                                link: eventItems[index].link, // Updated to eventItems
                                title: eventItems[index].title, // Updated to eventItems
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "View more...",
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}