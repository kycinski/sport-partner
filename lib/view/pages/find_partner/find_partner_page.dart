import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/find_partner_controller.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/pages/find_partner/add_post_page.dart';
import 'package:sport_partner/view/pages/find_partner/widgets/post_card.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';

class FindPartnerPage extends StatefulWidget {
  const FindPartnerPage({super.key, required this.categoryIdName});

  final String categoryIdName;

  @override
  State<FindPartnerPage> createState() => _FindPartnerPageState();
}

class _FindPartnerPageState extends State<FindPartnerPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context.read<FindPartnerController>().fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mainOptions.findPartner'.tr()),
        flexibleSpace: AppTheme.defaultAppBarTheme,
      ),
      body: CustomGradientBackground(
        child: FutureBuilder(
          future: context.read<FindPartnerController>().fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<FindPartnerController>(
                builder: (context, findPartnerController, _) {
                  if (findPartnerController.posts.isNotEmpty) {
                    return ListView.separated(
                      controller: _scrollController,
                      itemCount: findPartnerController.posts.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return PostCard(
                          post: findPartnerController.posts[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'findPartnerEmptyList'.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserController>().userConfirmedDetails
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPostPage(categoryIdName: widget.categoryIdName),
                  ),
                )
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Aby dodawać posty musisz uzupełnić swój profil'),
                  ),
                );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
