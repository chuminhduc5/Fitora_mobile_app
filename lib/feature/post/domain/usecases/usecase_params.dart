import 'posts/create_post_use_case.dart' as create_post_params;
import 'posts/update_post_use_case.dart' as update_post_params;
import 'posts/upload_file_use_case.dart' as upload_file_params;
import 'comments/create_comment_use_case.dart' as create_comment_params;
import 'comments/update_comment_use_case.dart' as update_comment_params;
import 'interact/vote_post_use_case.dart' as vote_post_params;
import 'interact/vote_comment_use_case.dart' as vote_comment_params;
import 'categories/create_category_use_case.dart' as create_category_use_case;

typedef CreatePostParams = create_post_params.Params;
typedef UpdatePostParams = update_post_params.Params;
typedef UploadFileParams = upload_file_params.Params;

typedef CreateCommentParams = create_comment_params.Params;
typedef UpdateCommentParams = update_comment_params.Params;

typedef VotePostParams = vote_post_params.Params;
typedef VoteCommentParams = vote_comment_params.Params;

typedef CreateCategoryParams = create_category_use_case.Params;
