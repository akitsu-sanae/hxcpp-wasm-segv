
## minimum code for SEGV in hxcpp/wasm

I got SEGV error when calling Haxe function on a web browser.

This haxe program in `Test.hx` is converted into C++ via hxcpp, and the C++ program is converted to wasm via emcc.
The JavaScript program in `Test.html` calls the converted wasm function.

I think that this is because I call the Haxe function by a wrong way.
I wraped Haxe function to C function in `extern.cpp`, and JavaScript program calls this.
This may be causing SEGV in barbage collection code.
But I couldn't find any other ways.

### How to reproduce SEGV

1. `haxe build.hxml`
2. open `Test.html` in your Web browser
3. click `test` link
4. you will get `RuntimeError: index out of bounds` error

I found this problem with Firefox Nightly 69.0a1 (2019-05-22) (64bit).


Note: this problem was solved. the correct codes are on the `correct` branch.

