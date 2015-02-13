check () {
	name="WERCKER_MAVEN_CENTRAL_$(echo $1 | tr '-' '_' | tr '[a-z]' '[A-Z]')"
	value=$(eval "echo \${$name}")
	if [ ! -n "$value" ]; then
		error "Could not recognize: $1"
		exit 1
	fi
}

names="
project-url
license-name
license-url
scm-url
scm-connection
developer-id
developer-name
developer-url
repository-username
repository-password
pgp-secring
pgp-passphrase
"

for name in $names
do
	check "$name"
done
