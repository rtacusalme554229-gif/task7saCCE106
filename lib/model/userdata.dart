
import 'account.dart';
import 'friend.dart';
import 'userpost.dart';
import 'usercomment.dart';

class Userdata {
  final Account myUserAccount = Account(
    name: 'Renan Angelo C. Tacusalme',
    email: 'Michaelvelez23@gmail.co',
    img: 'assets/person1.jpg',
    numFollowers: '10 Million',
    numFollowing: '500',
    numPosts: '350',
    numFriends: '6',
  );

  final List<Friend> friendList = [
    Friend(
      img: 'assets/person1.jpg',
      name: 'Alice',
    ),
    Friend(
      img: 'assets/person2.jpg',
      name: 'Bob',
    ),
    Friend(
      img: 'assets/person3.jpg',
      name: 'Charlie',
    ),
    Friend(
      img: 'assets/person4.jpg',
      name: 'Diana',
    ),
    Friend(
      img: 'assets/person5.jpg',
      name: 'Ethan',
    ),
    Friend(
      img: 'assets/person6.jpg',
      name: 'Fiona',
    ),
  ];

  final List<Userpost> userList = [
    Userpost(
      id: 'post1',
      userimg: 'assets/person1.jpg',
      username: 'John Doe',
      time: '2 hrs ago',
      postcontent: 'Had a great day at the beach!',
      posting: 'assets/pavlova.jpeg',
      numcomments: '24',
      numshare: '5',
      isLiked: false,
    ),
    Userpost(
      id: 'post2',
      userimg: 'assets/person2.jpg',
      username: 'Jane Smith',
      time: '3 hrs ago',
      postcontent: 'Just finished a 5k run!',
      posting: 'assets/post2.jpg',
      numcomments: '18',
      numshare: '3',
      isLiked: false,
    ),
    Userpost(
      id: 'post3',
      userimg: 'assets/person3.jpg',
      username: 'Mike Johnson',
      time: '5 hrs ago',
      postcontent: 'Enjoying the weekend!',
      posting: 'assets/post3.jpg',
      numcomments: '12',
      numshare: '2',
      isLiked: false,
    ),
  ];

  final List<Usercomment> commentList = [
    Usercomment(
      commenterImg: 'assets/person2.jpg',
      commenterName: 'Jane Smith',
      commentTime: '1 hr ago',
      commentContent: 'Looks fun!',
    ),
    Usercomment(
      commenterImg: 'assets/person3.jpg',
      commenterName: 'Mike Johnson',
      commentTime: '30 mins ago',
      commentContent: 'Wish I was there!',
    ),
    Usercomment(
      commenterImg: 'assets/person4.jpg',
      commenterName: 'Emily Davis',
      commentTime: '15 mins ago',
      commentContent: 'Great photo!',
    ),
  ];
}
