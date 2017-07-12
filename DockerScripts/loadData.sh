#~/bin/sh

# Starting virtuoso on the background
echo "Starting virtuoso..."
virtuoso-t +wait +configfile ${VOS_CONFIG}
echo "Virtuoso up"

VOS_USER=dba
VOS_PASS=dba
VOS_PORT=1111
VOS_SHARE=/tmp/share
VOS="isql $VOS_PORT $VOS_USER $VOS_PASS verbose=off errors=stdout"

echo "Install..."
$VOS install_pkgs.sql
echo "Import..."
$VOS import_rdf.sql
echo "Update..."
$VOS update_rdf.sql
echo "Post install..."
$VOS post_install.sql

echo "Killing virtuoso..."
killall5
sleep 30
echo "Virtuoso down"
