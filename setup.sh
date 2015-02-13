case "$WERCKER_MAVEN_CENTRAL_LICENSE_NAME" in
"GPL") NAME="GNU General Public License (GPL)"; URL="http://www.gnu.org/licenses/gpl.txt";;
"GPL2") NAME="GNU General Public License Version 2 (GPL 2)"; URL="http://www.gnu.org/licenses/gpl-2.0.txt";;
"LGPL") NAME="GNU Lesser General Public License"; URL="http://www.gnu.org/licenses/lgpl.txt";;
"Apache") NAME="Apache License, Version 2.0"; URL="http://www.apache.org/licenses/LICENSE-2.0.txt";;
"MIT") NAME="MIT License"; URL="http://www.opensource.org/licenses/mit-license.php";;
esac

export WERCKER_MAVEN_CENTRAL_LICENSE_NAME="$NAME"
export WERCKER_MAVEN_CENTRAL_LICENSE_URL=${WERCKER_MAVEN_CENTRAL_LICENSE_URL:-$URL}

if [ "${WERCKER_MAVEN_CENTRAL_SCM_URL%%:*}" == "git@github.com" ]
then
	export WERCKER_MAVEN_CENTRAL_SCM_CONNECTION=${WERCKER_MAVEN_CENTRAL_SCM_CONNECTION:-scm:git:$WERCKER_MAVEN_CENTRAL_SCM_URL}
	export WERCKER_MAVEN_CENTRAL_DEVELOPER_ID=${WERCKER_MAVEN_CENTRAL_DEVELOPER_ID:-$(echo $WERCKER_MAVEN_CENTRAL_SCM_URL | sed 's/.*:\(.*\)\/.*/\1/')}
	export WERCKER_MAVEN_CENTRAL_DEVELOPER_URL=${WERCKER_MAVEN_CENTRAL_DEVELOPER_URL:-https://github.com/$WERCKER_MAVEN_CENTRAL_DEVELOPER_ID}
	export WERCKER_MAVEN_CENTRAL_DEVELOPER_NAME=${WERCKER_MAVEN_CENTRAL_DEVELOPER_NAME:-$(curl $WERCKER_MAVEN_CENTRAL_DEVELOPER_URL 2>/dev/null | grep '<title>' | sed 's/.*(\(.*\)).*/\1/')}
fi

