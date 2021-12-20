import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/models/member.dart';
import '../../../../core/themes/text.dart';
import '../../../../core/widgets/member_image_leading.dart';
import '../controllers/member_controller.dart';
import 'member_info.dart';

class MembersList extends StatelessWidget {
  const MembersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<MembersController>(
          builder: (controller) => controller.isFetchingUser
              ? const _LoadingData()
              : controller.allMembers.isNotEmpty
                  ? ListView.separated(
                      itemCount: controller.allMembers.length,
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return _MemberListTile(
                          member: controller.allMembers[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 7,
                        );
                      },
                    )
                  : const _NoMemberFound(),
        ),
      ),
    );
  }
}

class _NoMemberFound extends StatelessWidget {
  const _NoMemberFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.7,
            child: Image.asset(
              AppImages.illustrationMemberEmpty,
            ),
          ),
          AppSizes.hGap20,
          const Text('No Member Found'),
        ],
      ),
    );
  }
}

class _MemberListTile extends StatelessWidget {
  const _MemberListTile({
    Key? key,
    required this.member,
  }) : super(key: key);

  final Member member;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Get.to(() => MemberInfoScreen(
        //       member: member,
        //     ));
        Get.bottomSheet(
          MemberInfoScreen(member: member),
          isScrollControlled: true,
          useRootNavigator: true,
        );
      },
      leading: Hero(
        tag: member.memberID ?? member.memberNumber,
        child: MemberImageLeading(
          imageLink: member.memberPicture,
        ),
      ),
      title: Text(member.memberName),
      subtitle: Text(member.memberNumber.toString()),
      trailing: const Icon(
        Icons.info_outlined,
        color: AppColors.appGreen,
      ),
    );
  }
}

// To Add A Loading List Effect
class _LoadingData extends StatelessWidget {
  const _LoadingData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.shimmerHighlightColor,
          child: ListTile(
            leading: const CircleAvatar(),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppDefaults.defaulBorderRadius,
                  ),
                  child: Text(
                    'Hello Testge g',
                    style: AppText.b1,
                  ),
                ),
                AppSizes.hGap5,
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppDefaults.defaulBorderRadius,
                  ),
                  child: const Text('+852 XXXX XXXXgegege g'),
                ),
              ],
            ),
            trailing: const Icon(Icons.info_rounded),
          ),
        );
      },
    );
  }
}