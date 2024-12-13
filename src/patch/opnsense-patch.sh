# Copyright (c) 2016-2024 Franco Fichtner <franco@opnsense.org>
CONFIG="core"
patch_repository()
{
	REPOSITORY=${1}

	case ${REPOSITORY} in
	*core*)
		PREFIX="/usr/local"
		PATCHLEVEL="2"
		CONFIG="core"
		;;
	*installer*)
		PREFIX="/usr/libexec/bsdinstall"
		PATCHLEVEL="2"
		CONFIG="installer"
		;;
	*plugins*)
		PREFIX="/usr/local"
		PATCHLEVEL="4"
		CONFIG="plugins"
		;;
	*update*)
		PREFIX="/usr/local/sbin"
		PATCHLEVEL="3"
		CONFIG="update"
		;;
	*)
		echo "Unknown repository default: ${REPOSITORY}" >&2
		exit 1
		;;
	esac
}

		patch_repository ${OPTARG}
	for PATCH in $(find -s ${CACHEDIR} -type f); do
		if [ "${FILE%-*}" != ${CONFIG} ]; then
			continue

		if [ "$(echo ${HASH##*-} | cut -c -${ARGLEN})" != ${ARG} ]; then
			continue
		fi

		echo ${FILE}
		return

		if [ "${FILE%-*}" != ${CONFIG} ]; then
			continue
		fi

patch_setup()
{
	# only allow patching with the right -a option set
	URL="${ARG#"${SITE}/${ACCOUNT}/"}"
	if [ "${URL}" != ${ARG} ]; then
		ARG=${URL#*/commit/}
		patch_repository ${URL%/commit/*}
		return
	fi

	# error to the user if -a did not match
	URL="${ARG#"${SITE}/"}"
	if [ "${URL}" != ${ARG} ]; then
		echo "Account '${ACCOUNT}' does not match given URL." >&2
		exit 1
	fi

	# continue here with a hash-only argument
}

	patch_setup # modify environment as required for patch

			ARGS="${ARGS} ${SITE}/${ACCOUNT}/${REPOSITORY}/commit/${FOUND#*-}"
	WANT="${CONFIG}-${ARG}"
	ARGS="${ARGS} ${SITE}/${ACCOUNT}/${REPOSITORY}/commit/${WANT#*-}"
	patch_setup # modify environment as required for patch
	ARG=${CONFIG}-${ARG} # reconstruct file name on disk

			if [ "${CONFIG}" = "installer" -o "${CONFIG}" == "update" ]; then
rm -f /tmp/opnsense_acl_cache.json /tmp/opnsense_menu_cache.xml