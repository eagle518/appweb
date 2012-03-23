#
#   build.sh -- Build It Shell Script to build Embedthis Appweb
#

PLATFORM="macosx-x86_64-debug"
CC="/usr/bin/cc"
CFLAGS="-fPIC -Wall -g -Wshorten-64-to-32"
DFLAGS="-DPIC -DCPU=X86_64"
IFLAGS="-Imacosx-x86_64-debug/inc"
LDFLAGS="-Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L/Users/mob/git/appweb/${PLATFORM}/lib -g -ldl"
LIBS="-lpthread -lm"

[ ! -x ${PLATFORM}/inc ] && mkdir -p ${PLATFORM}/inc ${PLATFORM}/obj ${PLATFORM}/lib ${PLATFORM}/bin
[ ! -f ${PLATFORM}/inc/buildConfig.h ] && cp src/buildConfig.default ${PLATFORM}/inc/buildConfig.h

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/mpr.h
cp -r /Users/mob/git/appweb/src/deps/mpr/mpr.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/mpr.h

${CC} -c -o ${PLATFORM}/obj/mprLib.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/mpr/mprLib.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libmpr.dylib -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -install_name @rpath/libmpr.dylib ${PLATFORM}/obj/mprLib.o ${LIBS}

${CC} -c -o ${PLATFORM}/obj/manager.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/mpr/manager.c

${CC} -o ${PLATFORM}/bin/appman -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/manager.o ${LIBS} -lmpr

${CC} -c -o ${PLATFORM}/obj/makerom.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/mpr/makerom.c

${CC} -o ${PLATFORM}/bin/makerom -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/makerom.o ${LIBS} -lmpr

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/pcre.h
cp -r /Users/mob/git/appweb/src/deps/pcre/pcre.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/pcre.h

${CC} -c -o ${PLATFORM}/obj/pcre.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/pcre/pcre.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libpcre.dylib -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -install_name @rpath/libpcre.dylib ${PLATFORM}/obj/pcre.o ${LIBS}

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/http.h
cp -r /Users/mob/git/appweb/src/deps/http/http.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/http.h

${CC} -c -o ${PLATFORM}/obj/httpLib.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/http/httpLib.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libhttp.dylib -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -install_name @rpath/libhttp.dylib ${PLATFORM}/obj/httpLib.o ${LIBS} -lmpr -lpcre

${CC} -c -o ${PLATFORM}/obj/http.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/deps/http/http.c

${CC} -o ${PLATFORM}/bin/http -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/http.o ${LIBS} -lhttp -lmpr -lpcre

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/sqlite3.h
cp -r /Users/mob/git/appweb/src/deps/sqlite/sqlite3.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/sqlite3.h

${CC} -c -o ${PLATFORM}/obj/sqlite3.o -arch x86_64 -fPIC -g ${DFLAGS} -I${PLATFORM}/inc src/deps/sqlite/sqlite3.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libsqlite3.dylib -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -install_name @rpath/libsqlite3.dylib ${PLATFORM}/obj/sqlite3.o ${LIBS}

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/appweb.h
cp -r /Users/mob/git/appweb/src/appweb.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/appweb.h

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/customize.h
cp -r /Users/mob/git/appweb/src/customize.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/customize.h

${CC} -c -o ${PLATFORM}/obj/config.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/config.c

${CC} -c -o ${PLATFORM}/obj/convenience.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/convenience.c

${CC} -c -o ${PLATFORM}/obj/dirHandler.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/dirHandler.c

${CC} -c -o ${PLATFORM}/obj/fileHandler.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/fileHandler.c

${CC} -c -o ${PLATFORM}/obj/log.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/log.c

${CC} -c -o ${PLATFORM}/obj/server.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/server.c

${CC} -dynamiclib -o ${PLATFORM}/lib/libappweb.dylib -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -install_name @rpath/libappweb.dylib ${PLATFORM}/obj/config.o ${PLATFORM}/obj/convenience.o ${PLATFORM}/obj/dirHandler.o ${PLATFORM}/obj/fileHandler.o ${PLATFORM}/obj/log.o ${PLATFORM}/obj/server.o ${LIBS} -lmpr -lhttp -lpcre -lpcre

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/edi.h
cp -r /Users/mob/git/appweb/src/esp/edi.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/edi.h

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/esp-app.h
cp -r /Users/mob/git/appweb/src/esp/esp-app.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/esp-app.h

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/esp.h
cp -r /Users/mob/git/appweb/src/esp/esp.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/esp.h

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/mdb.h
cp -r /Users/mob/git/appweb/src/esp/mdb.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/mdb.h

${CC} -c -o ${PLATFORM}/obj/edi.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/edi.c

${CC} -c -o ${PLATFORM}/obj/espAbbrev.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/espAbbrev.c

${CC} -c -o ${PLATFORM}/obj/espFramework.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/espFramework.c

${CC} -c -o ${PLATFORM}/obj/espHandler.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/espHandler.c

${CC} -c -o ${PLATFORM}/obj/espHtml.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/espHtml.c

${CC} -c -o ${PLATFORM}/obj/espSession.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/espSession.c

${CC} -c -o ${PLATFORM}/obj/espTemplate.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/espTemplate.c

${CC} -c -o ${PLATFORM}/obj/mdb.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/mdb.c

${CC} -c -o ${PLATFORM}/obj/sdb.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/sdb.c

${CC} -dynamiclib -o ${PLATFORM}/lib/mod_esp.dylib -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -install_name @rpath/mod_esp.dylib ${PLATFORM}/obj/edi.o ${PLATFORM}/obj/espAbbrev.o ${PLATFORM}/obj/espFramework.o ${PLATFORM}/obj/espHandler.o ${PLATFORM}/obj/espHtml.o ${PLATFORM}/obj/espSession.o ${PLATFORM}/obj/espTemplate.o ${PLATFORM}/obj/mdb.o ${PLATFORM}/obj/sdb.o ${LIBS} -lappweb -lmpr -lhttp -lpcre

${CC} -c -o ${PLATFORM}/obj/esp.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/esp/esp.c

${CC} -o ${PLATFORM}/bin/esp -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/edi.o ${PLATFORM}/obj/esp.o ${PLATFORM}/obj/espAbbrev.o ${PLATFORM}/obj/espFramework.o ${PLATFORM}/obj/espHandler.o ${PLATFORM}/obj/espHtml.o ${PLATFORM}/obj/espSession.o ${PLATFORM}/obj/espTemplate.o ${PLATFORM}/obj/mdb.o ${PLATFORM}/obj/sdb.o ${LIBS} -lappweb -lmpr -lhttp -lpcre

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/lib/esp.conf
cp -r /Users/mob/git/appweb/src/esp/esp.conf /Users/mob/git/appweb/macosx-x86_64-debug/lib/esp.conf

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/lib/esp-www
cp -r /Users/mob/git/appweb/src/esp/www /Users/mob/git/appweb/macosx-x86_64-debug/lib/esp-www

${CC} -c -o ${PLATFORM}/obj/cgiHandler.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/modules/cgiHandler.c

${CC} -dynamiclib -o ${PLATFORM}/lib/mod_cgi.dylib -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -install_name @rpath/mod_cgi.dylib ${PLATFORM}/obj/cgiHandler.o ${LIBS} -lappweb -lmpr -lhttp -lpcre

${CC} -c -o ${PLATFORM}/obj/phpHandler.o -arch x86_64 -fPIC -g ${DFLAGS} -I${PLATFORM}/inc -I../packages-macosx-x86_64/php/php-5.3.8 -I../packages-macosx-x86_64/php/php-5.3.8/main -I../packages-macosx-x86_64/php/php-5.3.8/Zend -I../packages-macosx-x86_64/php/php-5.3.8/TSRM src/modules/phpHandler.c

${CC} -dynamiclib -o ${PLATFORM}/lib/mod_php.dylib -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L/Users/mob/git/packages-macosx-x86_64/php/php-5.3.8/.libs -install_name @rpath/mod_php.dylib ${PLATFORM}/obj/phpHandler.o ${LIBS} -lphp5 -lappweb -lmpr -lhttp -lpcre

${CC} -c -o ${PLATFORM}/obj/auth.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/utils/auth.c

${CC} -o ${PLATFORM}/bin/auth -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/auth.o ${LIBS} -lmpr

${CC} -c -o ${PLATFORM}/obj/cgiProgram.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/utils/cgiProgram.c

${CC} -o ${PLATFORM}/bin/cgiProgram -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/cgiProgram.o ${LIBS}

${CC} -c -o ${PLATFORM}/obj/setConfig.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/utils/setConfig.c

${CC} -o ${PLATFORM}/bin/setConfig -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/setConfig.o ${LIBS} -lmpr

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/appwebMonitor.h
cp -r /Users/mob/git/appweb/src/server/appwebMonitor.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/appwebMonitor.h

${CC} -c -o ${PLATFORM}/obj/appweb.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/server/appweb.c

${CC} -o ${PLATFORM}/bin/appweb -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/appweb.o ${LIBS} -lappweb -lmpr -lhttp -lpcre

rm -rf /Users/mob/git/appweb/macosx-x86_64-debug/inc/testAppweb.h
cp -r /Users/mob/git/appweb/src/test/testAppweb.h /Users/mob/git/appweb/macosx-x86_64-debug/inc/testAppweb.h

${CC} -c -o ${PLATFORM}/obj/testAppweb.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/test/testAppweb.c

${CC} -c -o ${PLATFORM}/obj/testHttp.o -arch x86_64 ${CFLAGS} ${DFLAGS} -I${PLATFORM}/inc src/test/testHttp.c

${CC} -o ${PLATFORM}/bin/testAppweb -arch x86_64 -Wl,-rpath,@executable_path/../lib -Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/ -L${PLATFORM}/lib -g -ldl -L${PLATFORM}/lib ${PLATFORM}/obj/testAppweb.o ${PLATFORM}/obj/testHttp.o ${LIBS} -lappweb -lmpr -lhttp -lpcre

echo '#!/Users/mob/git/appweb/macosx-x86_64-debug/bin/cgiProgram' >/Users/mob/git/appweb/src/test/cgi-bin/testScript ; chmod +x /Users/mob/git/appweb/src/test/cgi-bin/testScript
echo -e '#!`type -p sh`' >/Users/mob/git/appweb/src/test/web/caching/cache.cgi
echo -e '' >>/Users/mob/git/appweb/src/test/web/caching/cache.cgi
echo -e 'echo HTTP/1.0 200 OK' >>/Users/mob/git/appweb/src/test/web/caching/cache.cgi
echo -e 'echo Content-Type: text/plain' >>/Users/mob/git/appweb/src/test/web/caching/cache.cgi
echo -e 'date' >>/Users/mob/git/appweb/src/test/web/caching/cache.cgi
chmod +x /Users/mob/git/appweb/src/test/web/caching/cache.cgi
echo -e '#!`type -p sh`' >/Users/mob/git/appweb/src/test/web/basic/basic.cgi
echo -e '' >>/Users/mob/git/appweb/src/test/web/basic/basic.cgi
echo -e 'echo Content-Type: text/plain' >>/Users/mob/git/appweb/src/test/web/basic/basic.cgi
echo -e '/usr/bin/env' >>/Users/mob/git/appweb/src/test/web/basic/basic.cgi
chmod +x /Users/mob/git/appweb/src/test/web/basic/basic.cgi
cp /Users/mob/git/appweb/macosx-x86_64-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/cgi-bin/cgiProgram
cp /Users/mob/git/appweb/macosx-x86_64-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/cgi-bin/nph-cgiProgram
cp /Users/mob/git/appweb/macosx-x86_64-debug/bin/cgiProgram '/Users/mob/git/appweb/src/test/cgi-bin/cgi Program'
cp /Users/mob/git/appweb/macosx-x86_64-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/web/cgiProgram.cgi
chmod +x /Users/mob/git/appweb/src/test/cgi-bin/* /Users/mob/git/appweb/src/test/web/cgiProgram.cgi
