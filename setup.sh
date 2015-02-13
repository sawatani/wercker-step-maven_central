export WERCKER_MAVEN_CENTRAL_DEVELOPER_ID=${WERCKER_MAVEN_CENTRAL_DEVELOPER_ID:-$WERCKER_GIT_OWNER}
if [ "${WERCKER_GIT_DOMAIN}" == "github.com" ]
then
	export WERCKER_MAVEN_CENTRAL_DEVELOPER_URL=${WERCKER_MAVEN_CENTRAL_DEVELOPER_URL:-https://$WERCKER_GIT_DOMAIN/$WERCKER_MAVEN_CENTRAL_DEVELOPER_ID}
	export WERCKER_MAVEN_CENTRAL_DEVELOPER_NAME=${WERCKER_MAVEN_CENTRAL_DEVELOPER_NAME:-$(curl $WERCKER_MAVEN_CENTRAL_DEVELOPER_URL 2>/dev/null | grep '<title>' | sed 's/.*(\(.*\)).*/\1/')}

	export WERCKER_MAVEN_CENTRAL_PROJECT_URL=${WERCKER_MAVEN_CENTRAL_PROJECT_URL:-$WERCKER_MAVEN_CENTRAL_DEVELOPER_URL/$WERCKER_GIT_REPOSITORY}
	export WERCKER_MAVEN_CENTRAL_SCM_URL=${WERCKER_MAVEN_CENTRAL_SCM_URL:-$WERCKER_MAVEN_CENTRAL_PROJECT_URL.git}
	export WERCKER_MAVEN_CENTRAL_SCM_CONNECTION=${WERCKER_MAVEN_CENTRAL_SCM_CONNECTION:-scm:git:$WERCKER_MAVEN_CENTRAL_SCM_URL}
fi

LICENSE="$WERCKER_ROOT/LICENSE"
if [ -f "$LICENSE" ]
then
	line1=$(cat $LICENSE | head -n1)
	line2=$(cat $LICENSE | head -n2 | tail -n1)

	if [ "$(echo "$line1" | grep 'GNU')x" == "x" ]
	then
		if [ "$(echo "$line1" | grep 'Apache')x" == "x" ]
		then
			if [ "$(echo "$line1" | grep 'MIT')x" == "x" ]
			then
				echo "No match license"
			else
				NAME="MIT License"
				URL="http://www.opensource.org/licenses/mit-license.php"
			fi
		else
			if [ "$(echo "$line2" | grep 'Version 2.0')x" == "x" ]
			then
				echo "No match license"
			else
				NAME="Apache License, Version 2.0"
				URL="http://www.apache.org/licenses/LICENSE-2.0.txt"
			fi
		fi
	else
		if [ "$(echo "$line1" | grep 'LESSER')x" == "x" ]
		then
			if [ "$(echo "$line2" | grep 'Version 3,')x" == "x" ]
			then
				if [ "$(echo "$line2" | grep 'Version 2,')x" == "x" ]
				then
					echo "No match license"
				else
					NAME="GNU General Public License Version 2 (GPL 2)"
					URL="http://www.gnu.org/licenses/gpl-2.0.txt"
				fi
			else
				NAME="GNU General Public License (GPL)"
				URL="http://www.gnu.org/licenses/gpl.txt"
			fi
		else
			NAME="GNU Lesser General Public License"
			URL="http://www.gnu.org/licenses/lgpl.txt"
		fi
	fi

	export WERCKER_MAVEN_CENTRAL_LICENSE_NAME="$NAME"
	export WERCKER_MAVEN_CENTRAL_LICENSE_URL=${WERCKER_MAVEN_CENTRAL_LICENSE_URL:-$URL}
fi
