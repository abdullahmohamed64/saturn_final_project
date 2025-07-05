/*
<br />
<b>Warning</b>:  Undefined array key "category" in <b>C:\xampp\htdocs\saturn\functions.php</b> on line <b>4</b><br />
{
    "status": "success",
    "data": [
        {
            "id": 1,
            "user_id": 1,
            "type": "image",
            "category": "pic",
            "name_image": "6169isg1.jpg",
            "description": "00",
            "created_at": "2025-03-11 14:55:51",
            "likes_count": 2
        },
        {
            "id": 2,
            "user_id": 1,
            "type": "image",
            "category": "logos",
            "name_image": "4309boy-anim.jpg",
            "description": "01",
            "created_at": "2025-03-11 14:57:29",
            "likes_count": 3
        },
        {
            "id": 3,
            "user_id": 1,
            "type": "image",
            "category": "home design",
            "name_image": "6269FB_IMG_1682102387804.jpg",
            "description": "02",
            "created_at": "2025-03-11 14:58:27",
            "likes_count": 0
        },
        {
            "id": 4,
            "user_id": 2,
            "type": "image",
            "category": "animation",
            "name_image": "5859324009.jpg",
            "description": "03",
            "created_at": "2025-03-11 14:59:22",
            "likes_count": 0
        },
        {
            "id": 5,
            "user_id": 2,
            "type": "image",
            "category": "painting",
            "name_image": "273320240124_133210.jpg",
            "description": "04",
            "created_at": "2025-03-11 15:00:06",
            "likes_count": 0
        },
        {
            "id": 6,
            "user_id": 2,
            "type": "image",
            "category": "handmade",
            "name_image": "5154Snapinst.app_474049739_17957723402855448_1899093714875450547_n_1080.jpg",
            "description": "05",
            "created_at": "2025-03-11 15:00:43",
            "likes_count": 0
        }
    ]
}
*/

import 'package:saturn/features/home/data/models/art_model.dart';

class CategorysResponseModel {
  final List<PostModel> arts = [];

  CategorysResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((item) => arts.add(PostModel.fromJson(item)));
    }
  }
}
