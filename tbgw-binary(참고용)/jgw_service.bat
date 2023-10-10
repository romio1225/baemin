@echo off

:: setting directories
set JGW_HOME_PATH=%CD%
set JGW_LIB_PATH=%JGW_HOME_PATH%\lib
set JGW_LOG_PATH=%JGW_HOME_PATH%\log

:: setting CLASSPATH
set JAVA_GATEWAY="%JGW_LIB_PATH%\tbgateway.jar"
set COMMONS_DAEMON="%JGW_LIB_PATH%\commons-daemon-1.0.6.jar"
set COMMONS_COLLECTIONS="%JGW_LIB_PATH%\commons-collections.jar"
set COMMONS_POOL="%JGW_LIB_PATH%\commons-pool.jar"
set LOG4J="%JGW_LIB_PATH%\log4j-1.2.15.jar"
set MSSQL_JDBC="%JGW_LIB_PATH%\sqljdbc.jar";"%JGW_LIB_PATH%\sqljdbc4.jar"
set SYBASE_JDBC="%JGW_LIB_PATH%\jconn3.jar"
set GREENPLUM_JDBC="%JGW_LIB_PATH%\postgresql-8.4-701.jdbc3.jar"

set JGW_CLASSPATH=%JAVA_GATEWAY%;%COMMONS_DAEMON%;%COMMONS_COLLECTIONS%;%COMMONS_POOL%;%LOG4J%;%MSSQL_JDBC%;%SYBASE_JDBC%;%GREENPLUM_JDBC%

:: setting SERVICE values
set JGW_SRVC_NAME="TBGateway"
set JGW_SRVC_DISP_NAME="TmaxDataJavaGateway"
set JGW_SRVC_DESC="Service of JAVA Gateway for TmaxData."

:: setting PROCRUN variables
set PR_EXEC="%JGW_HOME_PATH%\prunsrv.exe"
set PR_STDOUT="%JGW_LOG_PATH%\jgw_service.out"
set PR_STDERR="%JGW_LOG_PATH%\jgw_service.err"
set PR_START_CLASS="com.tmax.tibero.gateway.main.GatewayMain"
set PR_START_METHOD="start"
set PR_START_PARAMS="-c jgw.cfg"
set PR_STOP_CLASS="com.tmax.tibero.gateway.main.GatewayMain"
set PR_STOP_METHOD="stop"
set PR_JVM_OPTIONS="-Dlog4j.configuration=file:jgwlog.properties"
set PR_LOG_LEVEL=Info
set PR_LOG_PATH="%JGW_LOG_PATH%"

if "%1" == "" goto usage
if %1 == uninstall goto uninstall
if %1 == install goto install

:usage
echo "Usage : jgw_service.bat install/uninstall"
goto end

:install
%PR_EXEC% //IS//%JGW_SRVC_NAME% --StartClass=%PR_START_CLASS% --StopClass=%PR_STOP_CLASS% --StartMethod=%PR_START_METHOD% --StartParams=%PR_START_PARAMS% --StopMethod=%PR_STOP_METHOD% --Startup=auto --StartMode=jvm --StopMode=jvm --JvmOptions=%PR_JVM_OPTIONS%  --JvmMs=1024 --JvmMx=1024 --LogLevel=%PR_LOG_LEVEL% --LogPath=%PR_LOG_PATH% --StdOutput=%PR_STDOUT% --StdError=%PR_STDERR% --Description=%JGW_SRVC_DESC% --Classpath=%JGW_CLASSPATH% --DisplayName=%JGW_SRVC_DISP_NAME%
goto end

:uninstall
%PR_EXEC% //DS//%JGW_SRVC_NAME% --LogLevel=%PR_LOG_LEVEL% --LogPath=%PR_LOG_PATH% --StdOutput=%PR_STDOUT% --StdError=%PR_STDERR%
goto end

:end
