import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Themes.dart';

class Avatar extends StatelessWidget {
  final double radius;

  final String? url;
  final VoidCallback? onTap;

  const Avatar({Key? key,this.url,required this.radius,this.onTap}) : super(key: key);
  const Avatar.small({Key? key,this.url,this.onTap}) : radius=16, super(key: key);
  const Avatar.medium({Key? key,this.url,this.onTap}) : radius=22, super(key: key);
  const Avatar.large({Key? key,this.url,this.onTap}) : radius=44, super(key: key);


  @override
  Widget build(BuildContext context) {
    //return CircleAvatar(radius: radius,backgroundColor: Theme.of(context).cardColor,backgroundImage: CachedNetworkImageProvider(url!),);
    return GestureDetector(
      onTap: onTap,
      child: _avatar(context),
    );
  }
  Widget _avatar(BuildContext context){
    if(url!= null){
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url!),
        backgroundColor: Theme.of(context).cardColor,
      );
    }
    else{
      return CircleAvatar(
      radius: radius,
        backgroundColor: Theme.of(context).cardColor,
        child: Center(
          child: Text('?',style: TextStyle(fontSize: radius),),
        ),
      );
    }
  }
}



class IconBackground extends StatelessWidget {
  const IconBackground({Key? key,required this.icon,required this.onTap}) : super(key: key);
  final void Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          splashColor: AppColors.secondary,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(icon,size: 18,color: Colors.black,),
          ),

        ),
    );
  }
}
class IconBorder extends StatelessWidget {
  const IconBorder({Key? key,required this.icon,required this.onTap}) : super(key: key);
  final void Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      splashColor: AppColors.secondary,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 2,color: Theme.of(context).cardColor)
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,size: 16,
          ),
        ),
      ),
    );
  }
}


@immutable
class StoryData{
  const StoryData({required this.name,required this.url});
  final String name;
  final String url;
}
class StoryCard extends StatelessWidget {
  const StoryCard({Key? key,required this.storyData}) : super(key: key);
  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            storyData.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              letterSpacing: 0.3,
              fontWeight: FontWeight.bold
            ),
          ),
        ))
      ],
    );
  }
}
@immutable
class MessageData{
  final String senderName;
  final String message;
  final String datemessage;
  final String profilepicture;
  final DateTime messagedate;

  const MessageData({required this.senderName, required this.message, required this.datemessage, required this.profilepicture, required this.messagedate});
}
class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton({
    Key? key,
    required this.color,
    required this.icon,
    this.size = 54,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 8,
            blurRadius: 24,
          ),
        ],
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: AppColors.cardLight,
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class RoundedButton extends StatelessWidget {
  const RoundedButton(this.colors,this.title,this.onpress,this.textColor, {Key? key}) : super(key: key);
  final Color colors;
  final String title;
  final VoidCallback onpress;
  final Color textColor;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colors,
        borderRadius: BorderRadius.circular(30.0),

        child: MaterialButton(
          onPressed: onpress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

Padding ProfileIcon(BuildContext context,Function() onTap) {
  return Padding(
    padding: const EdgeInsets.only(right: 24),
    child: Avatar.medium(
      url: "https://picsum.photos/seed/3/300/300",
      onTap: onTap,
    ),
  );
}


//