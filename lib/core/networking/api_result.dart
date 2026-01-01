import "package:dartz/dartz.dart";

import "api_error_model.dart";

typedef RepoResult<T> = Either<ApiErrorModel, T>;
