. ./setup.sh

pomExtra="<url>${WERCKER_MAVEN_CENTRAL_PROJECT_URL}</url>
  <licenses>
    <license>
      <name>${WERCKER_MAVEN_CENTRAL_LICENSE_NAME}</name>
      <url>${WERCKER_MAVEN_CENTRAL_LICENSE_URL}</url>
      <distribution>repo</distribution>
    </license>
  </licenses>
  <scm>
    <url>${WERCKER_MAVEN_CENTRAL_SCM_URL}</url>
    <connection>${WERCKER_MAVEN_CENTRAL_SCM_CONNECTION}</connection>
  </scm>
  <developers>
    <developer>
      <id>${WERCKER_MAVEN_CENTRAL_DEVELOPER_ID}</id>
      <name>${WERCKER_MAVEN_CENTRAL_DEVELOPER_NAME}</name>
      <url>${WERCKER_MAVEN_CENTRAL_DEVELOPER_URL}</url>
    </developer>
  </developers>"

echo "POM Extra: $pomExtra"

mkdir -vp project
cat <<EOF >> project/plugins.sbt
 
addSbtPlugin("com.jsuereth" % "sbt-pgp" % "1.0.0")
EOF

cat <<EOF > wercker-publish.sbt
////////////////
// PGP Settings for sbt-pgp plugin
 
pgpSecretRing := file("wercker-secring.gpg")
 
////////////////
// Repository Settings
 
publishMavenStyle := true
 
publishTo <<= version { (v: String) =>
  val nexus = "https://oss.sonatype.org/"
  if (v.trim.endsWith("SNAPSHOT"))
    Some("snapshots" at nexus + "content/repositories/snapshots")
  else
    Some("releases"  at nexus + "service/local/staging/deploy/maven2")
}
 
publishArtifact in Test := false
 
pomIncludeRepository := { _ => false }
 
pomExtra := (${pomExtra})
 
credentials += Credentials("Sonatype Nexus Repository Manager", 
                           "oss.sonatype.org", 
                           "${WERCKER_MAVEN_CENTRAL_SONATYPE_USERNAME}",
                           "${WERCKER_MAVEN_CENTRAL_SONATYPE_PASSWORD}")
EOF

echo "$WERCKER_MAVEN_CENTRAL_SECRING" | base64 -d > wercker-secring.gpg

echo "$WERCKER_MAVEN_CENTRAL_PGP_PASSPHRASE" | sbt publish-signed
