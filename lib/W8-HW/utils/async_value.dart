class AsyncValue<T> {
  final T? data;
  final Object? error;
  final bool isLoading;

  AsyncValue({
    required this.data,
    required this.error,
    required this.isLoading,
  });

  AsyncValue.loading() : data = null, error = null, isLoading = true;
  AsyncValue.error(this.error) : data = null, isLoading = false;
  AsyncValue.data(this.data) : error = null, isLoading = false;
}
