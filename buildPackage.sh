#!/bin/bash -e

PACKAGE_NAME=plus-us-tasks
VERSION_MAJOR=1
VERSION_MINOR=0
VERSION_BUILD=1
VERSION="$VERSION_MAJOR.$VERSION_MINOR-$VERSION_BUILD"
SEP="_"
PACKAGE_NAME_VERSION=$PACKAGE_NAME$SEP$VERSION
ARCHITECTURE=all
PACKAGE_DIR=builddeb/$PACKAGE_NAME_VERSION

echo '### COPYING FILES'
rm -fr $PACKAGE_DIR
mkdir -p $PACKAGE_DIR
rsync -a package/ $PACKAGE_DIR/

echo '### CREATING CONTROL FILE'
cd builddeb/$PACKAGE_NAME_VERSION
CONTROL_FILE="DEBIAN/control"
touch $CONTROL_FILE
echo "Package: ${PACKAGE_NAME}" > "$CONTROL_FILE"
echo "Version: $VERSION" >> "$CONTROL_FILE"
echo "Section: misc" >> "$CONTROL_FILE"
echo "Priority: extra" >> "$CONTROL_FILE"
echo "Architecture: $ARCHITECTURE" >> "$CONTROL_FILE"
echo "Essential: no" >> "$CONTROL_FILE"
echo "Installed-Size: `du -s usr | awk '{ print $1 }'`" >> "$CONTROL_FILE"
echo "Maintainer: Antoine Girard-Vallée <antoine.girard-vallee@usherbrooke.ca>" >> "$CONTROL_FILE"
echo "Homepage: http://plus-us.gel.usherbrooke.ca/plusustasks" >> "$CONTROL_FILE"
echo "Depends: tasksel (>= 3.23)" >> "$CONTROL_FILE"
echo "Description: PLUS-US tasks for tasksel" >> "$CONTROL_FILE"
echo " This package provides plus-us tasks in tasksel." >> "$CONTROL_FILE"

# Create md5sum
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums

cd ..

dpkg-deb -bv $PACKAGE_NAME_VERSION $PACKAGE_NAME_VERSION"_"$ARCHITECTURE".deb"
