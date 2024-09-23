# Reactive Store

**Reactive Store** is a **simple** and lightweight state management solution for Haxe. It provides a basic yet effective way to manage reactive states and listen to changes in your application. This library is designed to be straightforward and easy to use, making it ideal for small projects or learning reactive patterns.

## Features

- **Simple** reactive state management.
- Easy to subscribe to store changes.
- Combine multiple stores and run effects when any of them changes.

## Installation

To install the library in your project, simply clone the repository:

```bash
git clone https://github.com/Tygrain/reactive-store.git
```

## Usage

### Basic Usage with `Store`

The `Store` class is a simple way to track and manage reactive data. You can easily subscribe to changes and update the value as needed.

```haxe
import reactive.Store;

class Main {
    static function main() {
        // Create a simple store with an initial value
        var store = new Store(0);

        // Subscribe to changes in the store's value
        store.subscribe(() -> trace('New value: ' + store.value));

        // Update the store's value
        store.value = 10;  // This will trigger the subscription and print: "New value: 10"
    }
}
```

### Example with `effect`

Here's a more practical example where multiple stores are used to calculate the area of a rectangle. When either `length` or `width` changes, the `area` store automatically updates.

```haxe
import reactive.Store;
import reactive.effect;

class Main {
    static function main() {
        final length = new Store(5);
        final width = new Store(10);
        final area = new Store(0);

        // Automatically update the area when either length or width changes
        effect([length, width], () -> area.value = length.value * width.value);

        // Update length and width
        length.value = 6;  // Area will be updated to 72
        width.value = 12;  // Area will be updated to 72
    }
}
```

This example demonstrates how you can combine multiple stores using `effect` to automatically compute derived values, like the area in this case, based on changes in the reactive state.

## API

### `Store<T>`

A **simple** reactive store that holds data of type `T`. You can subscribe to changes and update its value.

#### Methods:

- **`new(initialData:T)`**: Create a new store with the initial data.
- **`value(get, set):T`**: Accessor for the store's data. Updating the value triggers subscribed listeners.
- **`subscribe(listener:() -> Void):Void`**: Subscribe to store updates. The `listener` is called every time the store's value changes.
- **`remove(listener:() -> Void):Void`**: Unsubscribe a listener from the store.
  
### `effect(deps:Array<Store<Dynamic>>, listener:() -> Void):() -> Void`

Subscribe to multiple stores at once. The `listener` is triggered whenever any of the stores in `deps` change. Returns a function to unsubscribe from all stores.

---