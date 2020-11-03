#!/bin/bash
#
# This script configures WordPress file permissions based on recommendations
# from http://codex.wordpress.org/Hardening_WordPress#File_permissions
#
# Author: Michael Conigliaro <mike [at] conigliaro [dot] org>
# modified by Jose Luis Moya - alsur.es
# 
# script original recibe path y nombre de la carpeta wp-content
# rehago para que sirva para solo éste wordpress (docker) y se pueda ejecutar sin parametros
# alternativa pasar parametros.... 
# 1 ruta
# 2 alternativa a wp-content

USER_ID=82
WP_OWNER=$USER_ID # <-- wordpress owner
WP_GROUP=$USER_ID # <-- wordpress group
WP_ROOT=${1:-../www/} # <-- name of root in first argument, defaults to ../ - this script located in etc/
WS_GROUP=$USER_ID # <-- webserver group

#in case wp-content changed use second value of bash
WP_CONTENT=${2:-cont} # <-- name of obfuscated wp-content on second argument defaults to cont

# reset to safe defaults
#todo excluir el .git
find ${WP_ROOT} -exec chown ${WP_OWNER}:${WP_GROUP} {} \;
find ${WP_ROOT} -type d -exec chmod 755 {} \;
find ${WP_ROOT} -type f -exec chmod 644 {} \;

# allow wordpress to manage wp-config.php (but prevent world access)
chgrp ${WS_GROUP} ${WP_ROOT}/wp-config.php
chmod 660 ${WP_ROOT}/wp-config.php

# allow wordpress to manage wp-content
#find ${WP_ROOT}/wp-content -exec chgrp ${WS_GROUP} {} \;
#find ${WP_ROOT}/wp-content -type d -exec chmod 775 {} \;
#find ${WP_ROOT}/wp-content -type f -exec chmod 664 {} \;

# modification when wp-content obfuscated
find ${WP_ROOT}/${WP_CONTENT} -exec chgrp ${WS_GROUP} {} \;
find ${WP_ROOT}/${WP_CONTENT} -type d -exec chmod 775 {} \;
find ${WP_ROOT}/${WP_CONTENT} -type f -exec chmod 664 {} \;
