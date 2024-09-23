package reactive;

class Store<T> {
	private var _data:T;
	private var _listeners = new Set<() -> Void>();
	public function new(initialData:T) _data = initialData;

	public var value(get, set):T;
	private function get_value() return _data;

	private function set_value(newValue:T) {
		_data = newValue;
		notifyListeners();
		return _data;
	}

	public function subscribe(listener:() -> Void) _listeners.push(listener);
	private function notifyListeners() for (listener in _listeners) listener();
	public function remove(listener:() -> Void) _listeners.remove(listener);
}

function effect(deps:Array<Store<Dynamic>>, listener:() -> Void) {
	for (store in deps) store.subscribe(listener);
	return () -> for (store in deps) store.remove(listener);
}