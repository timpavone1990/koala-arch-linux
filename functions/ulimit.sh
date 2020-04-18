function setUlimits() {
	cat $CONFIGURATION_FILES_DIR/limits.conf \
	    >> /etc/security/limits.conf
}
