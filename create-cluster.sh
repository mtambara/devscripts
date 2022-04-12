SOURCE_PORTAL=/lsc/tomcat
TARGET_PORTAL=/lsc/tomcat2
TARGET_JMX_PORT=8100
TARGET_JPDA_PORT=localhost:8001
TARGET_SHUTDOWN_PORT=8006
TARGET_HTTP_CONNECTOR_PORT=8081
TARGET_AJP_CONNECTOR_PORT=8010
TARGET_OSGI_CONSOLE=localhost:11312
TARGET_FABRIC_SERVER_PORT=8924

rm -rf $TARGET_PORTAL
cp -r -L $SOURCE_PORTAL $TARGET_PORTAL
rm -rf $TARGET_PORTAL/osgi/state
sed -i -e "s/-Dcom.sun.management.jmxremote.port=8099/-Dcom.sun.management.jmxremote.port=$TARGET_JMX_PORT/g" $TARGET_PORTAL/tomcat/bin/setenv.sh
sed -i -e "s/JPDA_ADDRESS=\"localhost:8000\"/JPDA_ADDRESS=\"$TARGET_JPDA_PORT\"/g" $TARGET_PORTAL/tomcat/bin/catalina.sh
sed -i -e "s/<Server port=\"8005\"/<Server port=\"$TARGET_SHUTDOWN_PORT\"/g" $TARGET_PORTAL/tomcat/conf/server.xml
sed -i -e "s/<Connector port=\"8080\"/<Connector port=\"$TARGET_HTTP_CONNECTOR_PORT\"/g" $TARGET_PORTAL/tomcat/conf/server.xml
sed -i -e "s/<Connector port=\"8009\"/<Connector port=\"$TARGET_AJP_CONNECTOR_PORT\"/g" $TARGET_PORTAL/tomcat/conf/server.xml
sed -i -e "s/liferay.home=\/lsc\/tomcat/liferay.home=\/lsc\/tomcat2/g" $TARGET_PORTAL/tomcat/webapps/ROOT/WEB-INF/classes/portal-ext.properties
echo -e "\nmodule.framework.properties.osgi.console=$TARGET_OSGI_CONSOLE" >> $TARGET_PORTAL/tomcat/webapps/ROOT/WEB-INF/classes/portal-ext.properties
echo -e "\nportal.fabric.server.port=$TARGET_FABRIC_SERVER_PORT" >> $TARGET_PORTAL/tomcat/webapps/ROOT/WEB-INF/classes/portal-ext.properties
