import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/category/category_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/category/category_form_input_data.dart';
import 'package:meta/meta.dart';

part 'category_form_event.dart';
part 'category_form_state.dart';

class CategoryFormBloc extends Bloc<CategoryFormEvent, CategoryFormState> {
  CategoryFormBloc() : super(const CategoryFormInitialState()) {
    on<CategoryLoadDataEvent>(_loadData);
    on<CategoryNameChangedEvent>(_nameChanged);
    on<CategorySlugChangedEvent>(_slugChanged);
    on<CategoryDescriptionChangedEvent>(_descriptionChanged);
    on<CategoryParentIdChangedEvent>(_parentIdChanged);
  }

  Future _loadData(CategoryLoadDataEvent event, Emitter emit) async {
    final updateData = CategoryFormInputData(
      inputName: event.params.name,
      inputSlug: event.params.slug,
      inputDescription: event.params.description,
      inputParentId: event.params.parentId,
      inputIsValid: inputValidator(event.params.name),
    );
    emit(CategoryFormDataState(updateData));
  }

  Future _nameChanged(CategoryNameChangedEvent event, Emitter emit) async {
    final updateData = CategoryFormInputData(
      inputName: event.name,
      inputSlug: state.data.slug,
      inputDescription: state.data.description,
      inputParentId: state.data.parentId,
      inputIsValid: inputValidator(event.name),
    );
    emit(CategoryFormDataState(updateData));
  }

  Future _slugChanged(CategorySlugChangedEvent event, Emitter emit) async {
    final updateData = CategoryFormInputData(
      inputName: state.data.name,
      inputSlug: event.slug,
      inputDescription: state.data.description,
      inputParentId: state.data.parentId,
      inputIsValid: inputValidator(state.data.name),
    );
    emit(CategoryFormDataState(updateData));
  }

  Future _descriptionChanged(
      CategoryDescriptionChangedEvent event, Emitter emit) async {
    final updateData = CategoryFormInputData(
      inputName: state.data.name,
      inputSlug: state.data.slug,
      inputDescription: event.description,
      inputParentId: state.data.parentId,
      inputIsValid: inputValidator(state.data.name),
    );
    emit(CategoryFormDataState(updateData));
  }

  Future _parentIdChanged(
      CategoryParentIdChangedEvent event, Emitter emit) async {
    final updateData = CategoryFormInputData(
      inputName: state.data.name,
      inputSlug: state.data.slug,
      inputDescription: state.data.description,
      inputParentId: event.parentId,
      inputIsValid: inputValidator(state.data.name),
    );
    emit(CategoryFormDataState(updateData));
  }

  bool inputValidator(String content) {
    if (content.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE CategoryFormBloc =====");
    return super.close();
  }
}
