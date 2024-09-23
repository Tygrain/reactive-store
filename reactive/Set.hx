package reactive;

@:forward(iterator, remove)
abstract Set<T>(Array<T>) to Array<T> {
	public inline function new(?a:Array<T>) this = a ?? [];
	@:from static public function fromArray<T>(a:Array<T>) return new Set<T>(a);
	public function push(v:T) if (!has(v)) this.push(v);
	inline function has(v:T) return this.indexOf(v) >= 0;
}