#!/bin/bash

BRANCH=${1:-master}

checkoutSubmodule() {
	(
		local name=${1##*/}
		echo "[----> Initing Submodule '${name}']"
		git submodule update "${name}" 2>/dev/null
		cd "${name}"
		git fetch origin ${BRANCH}:${BRANCH} 2>/dev/null
		git checkout ${BRANCH} 2>/dev/null
	)&
	spin $!
}

clone_and_init() {
	repo_dir=${1##*/}
	repo_dir=${repo_dir%.git}
	(
		echo "[----> Cloning '${repo_dir}']"
		git clone -b master --progress "$1" 2>/dev/null
		cd ${repo_dir}
		git fetch origin ${BRANCH}:${BRANCH} 2>/dev/null
		git checkout ${BRANCH} 2>/dev/null
		git submodule init 2>/dev/null
	)&
	spin $!
}

install() {
	(
		echo "[----> Installing '${1##*/}']"
		cd "$1"
		mvn -N install
	)&
	spin $!
}

integrationTest() {
	(
		echo "[----> Integration Testing '${1##*/}']"
		cd "$1"
		mvn integration-test -DskipTests=false
	)
}

spin() {
	local s=("|" "/" "-" '\x5C')
	local i=0
	while kill -0 $1 2> /dev/null; do
		echo -en "[${s[$i]}]"\\r
		i=$(( $i == 3 ? 0 : $i + 1 ))
		sleep .1
	done
}

START=$(date +%s.%N)

# (optional) Save this in your .profile or .bashrc for reuse, speeds up the build
export MAVEN_OPTS="-Xmx2048m -Declipse.p2.mirrors=false"

clone_and_init "git://git.eclipse.org/gitroot/platform/eclipse.platform.releng.aggregator.git"

cd "${repo_dir}"

checkoutSubmodule "eclipse.platform.runtime"
checkoutSubmodule "rt.equinox.framework"
checkoutSubmodule "rt.equinox.bundles"

install "eclipse-platform-parent"
install "eclipse.platform.releng.prereqs.sdk"

install "rt.equinox.framework"
install "rt.equinox.framework/bundles/org.eclipse.osgi"
install "rt.equinox.framework/bundles/org.eclipse.osgi.services"
install "rt.equinox.framework/bundles/org.eclipse.equinox.launcher"

install "rt.equinox.bundles"
install "rt.equinox.bundles/bundles/org.eclipse.equinox.http.servlet"
install "rt.equinox.bundles/bundles/org.eclipse.equinox.util"
install "rt.equinox.bundles/bundles/org.eclipse.equinox.ds"
install "rt.equinox.bundles/bundles/org.eclipse.equinox.http.jetty9"
install "rt.equinox.bundles/bundles/org.eclipse.equinox.common"
install "rt.equinox.bundles/bundles/org.eclipse.equinox.registry"
install "rt.equinox.bundles/bundles/org.eclipse.equinox.app"
install "rt.equinox.bundles/bundles/org.eclipse.equinox.preferences"

install "eclipse.platform.runtime"
install "eclipse.platform.runtime/bundles/org.eclipse.core.jobs"
install "eclipse.platform.runtime/bundles/org.eclipse.core.contenttype"
install "eclipse.platform.runtime/bundles/org.eclipse.core.runtime"

#integrationTest "rt.equinox.bundles/bundles/org.eclipse.equinox.http.servlet.tests"

END=$(date +%s.%N)
DIFF=$(bc -l <<< "scale=3; ($END - $START)")
echo "[----> Build Time: ${DIFF}s]"
