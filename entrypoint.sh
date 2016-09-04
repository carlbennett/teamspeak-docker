#!/bin/bash
# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:

# Checking if files exist to make sure we're backing up the database to data
if [ ! -f /opt/teamspeak/ts3server.sqlitedb ] \
    && [ -f /opt/tsdata/ts3server.sqlitedb ]; then
    ln -s /opt/tsdata/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ -f /opt/teamspeak/ts3server.sqlitedb ] \
    && [ ! -f /opt/tsdata/ts3server.sqlitedb ]; then
    mv /opt/teamspeak/ts3server.sqlitedb /opt/tsdata/ts3server.sqlitedb
    ln -s /opt/tsdata/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ -f /opt/teamspeak/ts3server.sqlitedb ] \
    && [ -f /opt/tsdata/ts3server.sqlitedb ]; then
    rm /opt/teamspeak/ts3server.sqlitedb
    ln -s /opt/tsdata/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ ! -f /opt/teamspeak/serverkey.dat ] \
    && [ -f /opt/tsdata/license/serverkey.dat ]; then
    ln -s /opt/tsdata/license/serverkey.dat /opt/teamspeak/serverkey.dat
fi

if [ ! -f /opt/teamspeak/licensekey.dat ] \
    && [ -f /opt/tsdata/license/licensekey.dat ]; then
    ln -s /opt/tsdata/license/licensekey.dat /opt/teamspeak/licensekey.dat
fi

# Run the teamspeak server
export LD_LIBRARY_PATH=/opt/teamspeak:/opt/tsdata:$LD_LIBRARY_PATH
cd /opt/teamspeak
./ts3server logpath=/opt/tsdata/logs
