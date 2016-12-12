# plus-us-tasks
Package which installs a tasksel task used to install all the PLUS-US distribution packages.

## Usage
Build with ./buildPackage.sh

## Files
buildPackage.sh: Used to build the debian package of the software. Generates the package/DEBIAN/control file with all necessary information.
package/DEBIAN/changelog: Changelog for major changes (when the version is updated)
package/DEBIAN/copyright: LiliQ-P license 1.1
package/usr/share/tasksel/descs/plus-us-tasks.desc: Tasksel task with PLUS-US packages.
