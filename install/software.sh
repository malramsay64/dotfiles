#!/usr/bin/env bash

# Installing all the software and versions I need in /usr/local

CWD=$(pwd)
PREFIX="/usr/local"
MAKE_DIR="$HOME/Downloads/Software"
MODULE_PATH="/usr/local/Modules/modulefiles"
EX_MODULE="$HOME/dotfiles/install/module"

echo "This script requires sudo to install in the default location of /usr/local
The preferred option is to run the commands
    $ sudo chown -R $USER:$USER /usr/local
    $ bash software.sh
    $ sudo chown -R root:root /usr/local"

mkdir -p "$MAKE_DIR"

download() {
    cd "$MAKE_DIR"
    wget "$1"
    echo ${1##*.}
    case ${1##*.} in
        zip)
            unzip $(basename $1)
            ;;
        gz)
            tar xvzf $(basename $1)
            ;;
        bz2)
            tar xvjf $(basename $1)
            ;;
        *)
            echo "Cannot extract $(basename $1)"
            rm $(basename $1)
            exit 1
    esac
    rm $(basename $1)
}

run-installer() {
    if [ -z "$1" ] ; then
        echo "Useage: install(<program>, <version>)"
        echo -e "\t this will install in the directory /usr/local/<program>/<version>"
        exit 1
    fi
    if [ -e "configure" ] ; then
        ./configure --prefix="/usr/local/$1/$2"
        make > build.log
        sudo make install >> build.log
    elif [ -e "CMakeLists.txt" ] ; then
        [ -d "build" ] || mkdir -p build
        cd build
        cmake .. -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX="/usr/local/$1/$2" > build.log
        make >> build.log
        sudo make install >> build.log
    fi
}

add-module(){
    if [ -z "$1" ] ; then
        echo "Useage: add-module(<program>, <version>)"
        echo -e "\t this will add the module <program>/<version>"
        echo -e "\t and make this version the default" 
        exit 0
    fi
    [ -d "$MODULE_PATH/$1" ] || sudo cp -r "$EX_MODULE" "$MODULE_PATH/$1"
    sudo ln -s "$MODULE_PATH/$1/.base" "$MODULE_PATH/$1/$2"
    sed "s/\".*\"/\"$2\"/" "$MODULE_PATH/$1/.vers" | sudo tee "$MODULE_PATH/$1/.vers"
}

install(){
    PROGRAM="$1"
    VERSION="$2"
    DOWNLOAD="$3"
    INSTALL_DIR="$PREFIX/$PROGRAM/$VERSION"
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Downloading $PROGRAM-$VERSION..."
        download "$DOWNLOAD"
        cd $PROGRAM-$VERSION
        echo "Installing $PROGRAM-$VERSION..."
        run-installer "$PROGRAM" "$VERSION"
        add-module "$PROGRAM" "$VERSION"
        cd "$MAKE_DIR"
        echo "Done!"
    fi
}

# cmake
VERSIONS="2.8.1 3.5.2"
for VERSION in $VERSIONS; do
    MAJOR_V="v${VERSION%.*}"
    install cmake $VERSION "https://cmake.org/files/$MAJOR_V/cmake-$VERSION.tar.gz"
done

# gcc
#VERSIONS="4.8.5 5.3.0"
#for VERSION in $VERSIONS; do
    #PROGRAM=gcc
    #install $PROGRAM $VERSION "http://www.netgull.com/gcc/releases/$PROGRAM-$VERSION/$PROGRAM-$VERSION.tar.bz2"
#done

# googletest
VERSIONS="1.7.0"
for VERSION in $VERSIONS; do
    PROGRAM=googletest
    install $PROGRAM $VERSION "https://github.com/google/$PROGRAM/archive/release-$VERSION.zip"
done



# google benchmark
VERSIONS="1.0.0"
for VERSION in $VERSIONS; do
    PROGRAM=benchmark
    install $PROGRAM $VERSION "https://github.com/google/$PROGRAM/archive/release-$VERSION.zip"
done

cd "$CWD"
