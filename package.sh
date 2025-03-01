#!/usr/bin/env bash

echo "::clean"
rm -rf target/*;
mkdir -p target;


package_theme() {
    echo "::package $1"
    tar czf "target/$1.tar.gz" "$1"
}

package_all() {
    echo "::package all"

    mkdir -p target/themes
    cp -r mint-blue-light target/themes/
    cp -r mint-blue-dark target/themes/
    cp -r mint-green-light target/themes/
    cp -r mint-green-dark target/themes/

    tar czf "target/themes.tar.gz" target/themes
    rm -r target/themes;
}

package_theme mint-blue-light
package_theme mint-blue-dark
package_theme mint-green-light
package_theme mint-green-dark

package_all;

echo "package with target/"
