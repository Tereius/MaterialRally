[settings]
os=Android
os.api_level=26
arch=x86_64
compiler=clang
compiler.version=14
compiler.libcxx=c++_shared
build_type=Release
[options]
qt/*:opengl=es2
[tool_requires]
android-ndk/r25b@com.github.tereius/stable
android-sdk/latest@com.github.tereius/stable
openjdk/19.0.2@com.github.tereius/stable
