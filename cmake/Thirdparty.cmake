############################################################################################################################################################  
## option 
## 
############################################################################################################################################################  

set(THIRDPARTY_PATH "${PROJECT_SOURCE_DIR}/thirdparty")

option(TARSCPP          "option for TarsCpp"         ON)
option(JSONCPP          "option for jsoncpp"         ON)
option(RANDOM           "option for random"          ON)
option(TINYXML2         "option for tinyxml2"        ON)
option(FMT              "option for fmt"             ON)
option(PCCL             "option for pccl"            ON)
option(CTPOPTION        "option for ctpoption"       ON)
option(HIREDIS          "option for hiredis"         ON)
option(REDISPLUS        "option for redis++"         ON)
option(MYSQLCLIENT      "option for mysqlclient"     ON)
option(MYSQLPP          "option for mysql++"         ON)
option(CPR              "option for cpr"             ON)


############################################################################################################################################################   
## definitions 
## 
############################################################################################################################################################  

#if (TARS_CPP)
#    add_definitions(-DTARS_CPP=1)
#endif ()


############################################################################################################################################################   
## zlib/curl
## apt install libcurl4-openssl-dev
## apt install zip
############################################################################################################################################################  

IF(UNIX)
	
    FIND_PACKAGE(ZLIB)
    IF(NOT ZLIB_FOUND)
        SET(ERRORMSG "zlib library not found. Please install appropriate package, remove CMakeCache.txt and rerun cmake.")        
        MESSAGE(FATAL_ERROR ${ERRORMSG})
    ELSE(ZLIB_FOUND)
		include_directories(${ZLIB_INCLUDE_DIRS})
    ENDIF()
    

    FIND_PACKAGE(CURL)
    IF(NOT CURL_FOUND)    
		SET(ERRORMSG "curl library not found. Please install appropriate package, remove CMakeCache.txt and rerun cmake.")        
        MESSAGE(FATAL_ERROR ${ERRORMSG})
	ELSE(CURL_FOUND)
		include_directories(${CURL_INCLUDE_DIRS})
    ENDIF()

	FIND_PACKAGE(Protobuf REQUIRED)
	IF(NOT PROTOBUF_FOUND)
	    SET(ERRORMSG "protobuf library not found. Please install appropriate package, remove CMakeCache.txt and rerun cmake.")        
        MESSAGE(FATAL_ERROR ${ERRORMSG})
	ELSE(PROTOBUF_FOUND)	
	    INCLUDE_DIRECTORIES(${PROTOBUF_INCLUDE_DIRS})
		INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR})
	ENDIF()
	
    
ENDIF(UNIX)




############################################################################################################################################################   
## TARSCPP 
## 
############################################################################################################################################################  

add_custom_target(thirdparty)
include(ExternalProject)

if (TARSCPP)

    set(TARSCPP_INCLUDE_DIRS "/usr/local/tars/cpp/include")
    set(TARSCPP_LIBRARY_DIRS "/usr/local/tars/cpp/lib") 
    set(TARSCPP_LIBRARY      "/usr/local/tars/cpp/lib/libtarsservant.a" "/usr/local/tars/cpp/lib/libtarsparse.a" "/usr/local/tars/cpp/lib/libtarsutil.a")
    
    #include_directories(${TARSCPP_INCLUDE_DIRS})
    #link_directories(${TARSCPP_LIBRARY_DIRS})


	if (NOT EXISTS "${THIRDPARTY_PATH}/TarsCpp/lib/libtarsservant.a" )
	
	    ExternalProject_Add(ADD_tarscpp                
            CONFIGURE_COMMAND ${CMAKE_COMMAND} . 
            SOURCE_DIR ${THIRDPARTY_PATH}/TarsCpp
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make 
            INSTALL_COMMAND make  install
            )  
            
	endif()


endif (TARSCPP)

############################################################################################################################################################   
## JSONCPP 
## 
############################################################################################################################################################  

if (JSONCPP)
	
    set(JSONCPP_INCLUDE_DIRS "/usr/local/include/json")
    set(JSONCPP_LIBRARY      "/usr/local/lib/libjsoncpp.a" )
    
    #include_directories(${JSONCPP_INCLUDE_DIRS})

    execute_process(COMMAND mkdir ${THIRDPARTY_PATH}/jsoncpp-Sandbox/jsoncpp/jsoncpp-build )   

    if (NOT EXISTS "${THIRDPARTY_PATH}/jsoncpp-Sandbox/jsoncpp/jsoncpp-build/lib/libjsoncpp.a" )
		
 		ExternalProject_Add(ADD_jsoncpp                
            CONFIGURE_COMMAND ${CMAKE_COMMAND} .. 
            SOURCE_DIR ${THIRDPARTY_PATH}/jsoncpp-Sandbox/jsoncpp/jsoncpp-build
            BUILD_IN_SOURCE 1
            BUILD_COMMAND   make
            INSTALL_COMMAND make  install
            ) 
            
	endif()

   
endif (JSONCPP)


############################################################################################################################################################   
## RANDOM 
## 
############################################################################################################################################################  

if (RANDOM)

    set(RANDOM_INCLUDE_DIRS "/usr/local/include")
    set(RANDOM_LIBRARY      "/usr/local/lib/librandom.a" )
    
    #include_directories(${RANDOM_INCLUDE_DIRS})   


    ExternalProject_Add(ADD_random                
            CONFIGURE_COMMAND ${CMAKE_COMMAND} . 
            SOURCE_DIR ${THIRDPARTY_PATH}/random
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make
            INSTALL_COMMAND make  install
            )

endif (RANDOM)

############################################################################################################################################################   
## TINYXML2 
## 
############################################################################################################################################################  

if (TINYXML2)

    set(TINYXML2_INCLUDE_DIRS "/usr/local/include")
    set(TINYXML2_LIBRARY      "/usr/local/lib/libtinyxml2.a" )
    
    #include_directories(${RANDOM_INCLUDE_DIRS})   


    ExternalProject_Add(ADD_tinyxml2                
            CONFIGURE_COMMAND ${CMAKE_COMMAND} . 
            SOURCE_DIR ${THIRDPARTY_PATH}/tinyxml2
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make
            INSTALL_COMMAND make  install
            )

endif (TINYXML2)



############################################################################################################################################################   
## FMT 
## 
############################################################################################################################################################  

if (FMT)

    set(FMT_INCLUDE_DIRS "/usr/local/include")
    set(FMT_LIBRARY      "/usr/local/lib/libfmt.a" )
    
    #include_directories(${FMT_INCLUDE_DIRS})   

    if (NOT EXISTS "${THIRDPARTY_PATH}/fmt/libfmt.a" )

	    ExternalProject_Add(ADD_fmt               
	            CONFIGURE_COMMAND ${CMAKE_COMMAND} . 
	            SOURCE_DIR ${THIRDPARTY_PATH}/fmt
	            BUILD_IN_SOURCE 1
	            BUILD_COMMAND make
	            INSTALL_COMMAND make  install
	            )

     endif()

endif (FMT)

############################################################################################################################################################   
## pccl 
## 
############################################################################################################################################################  

if (PCCL)

    set(PCCL_INCLUDE_DIRS "/usr/local/tars/cpp/include/pccl")
    set(PCCL_LIBRARY      "/usr/local/tars/cpp/lib/libpccl_logicrpc.a" )
    
    #include_directories(${PCCL_INCLUDE_DIRS})   

    if (NOT EXISTS "${THIRDPARTY_PATH}/pccl/build/pccl_logicrpc.a" )

	    ExternalProject_Add(ADD_pccl               
	            CONFIGURE_COMMAND ${CMAKE_COMMAND} ..
	            SOURCE_DIR ${THIRDPARTY_PATH}/pccl/build
	            BUILD_IN_SOURCE 1
	            BUILD_COMMAND make
	            INSTALL_COMMAND make  install
	            )

     endif()

endif (PCCL)


############################################################################################################################################################   
## CTPOPTION 
## 
############################################################################################################################################################  

if (CTPOPTION)	
	if ( ${CTPOPTION} STREQUAL  "3.5.8" )	
		set(CTPOPTION_VERSION           "3.5.8" )
	    set(CTPOPTION_INCLUDE_DIRS     "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8" )
	    set(CTPOPTION_LIBRARY          "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8/libsoptthostmduserapi_se.so" "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8/libsoptthosttraderapi_se.so" )
	    set(CTPOPTION_LIBRARY_1         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8/libsoptthostmduserapi_se.so"  )
	    set(CTPOPTION_LIBRARY_2         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8/libsoptthosttraderapi_se.so"  )
	    add_definitions(-DCTPOPTION_V3_5_8=1)	
	    
	elseif ( ${CTPOPTION} STREQUAL  "3.5.5.T1" )	
		set(CTPOPTION_VERSION           "3.5.5.T1" )        
	    set(CTPOPTION_INCLUDE_DIRS      "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_5_T1" )
	    set(CTPOPTION_LIBRARY           "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_5_T1/libthostmduserapi_se_t1.so" "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_5_T1/libthosttraderapi_se_t1.so"  )
	    set(CTPOPTION_LIBRARY_1         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_5_T1/libsoptthostmduserapi_se_t1.so"  )
	    set(CTPOPTION_LIBRARY_2         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_5_T1/libsoptthosttraderapi_se_t1.so"  )
	    add_definitions(-DCTP_V3_5_5_T1=1)	
	    
	elseif ( ${CTPOPTION} STREQUAL  "3.6.0.T1" )	
		set(CTPOPTION_VERSION           "3.6.0.T1" )        
	    set(CTPOPTION_INCLUDE_DIRS      "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_0_T1" )
	    set(CTPOPTION_LIBRARY           "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_0_T1/libsoptthostmduserapi_se_t1.so" "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_0_T1/libsoptthosttraderapi_se_t1.so"  )
	    set(CTPOPTION_LIBRARY_1         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_0_T1/libsoptthostmduserapi_se_t1.so"  )
	    set(CTPOPTION_LIBRARY_2         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_0_T1/libsoptthosttraderapi_se_t1.so"  )
	    add_definitions(-DCTP_V3_6_0_T1=1)		    
		    
	elseif ( ${CTPOPTION} STREQUAL  "3.6.2" )	
		set(CTPOPTION_VERSION           "3.6.2" )
	    set(CTPOPTION_INCLUDE_DIRS      "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_2" )
	    set(CTPOPTION_LIBRARY           "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_2/libsoptthostmduserapi_se.so" "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_2/libsoptthosttraderapi_se.so"  )
	    set(CTPOPTION_LIBRARY_1         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_2/libsoptthostmduserapi_se.so"  )
	    set(CTPOPTION_LIBRARY_2         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_2/libsoptthosttraderapi_se.so"  )
	    add_definitions(-DCTP_V3_6_2=1)	   
	    
	elseif ( ${CTPOPTION} STREQUAL  "3.6.3" )	
		set(CTPOPTION_VERSION           "3.6.3" )
	    set(CTPOPTION_INCLUDE_DIRS      "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_3" )
	    set(CTPOPTION_LIBRARY           "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_3/libsoptthostmduserapi_se.so" "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_3/libsoptthosttraderapi_se.so"  )
	    set(CTPOPTION_LIBRARY_1         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_3/libsoptthostmduserapi_se.so"  )
	    set(CTPOPTION_LIBRARY_2         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_6_3/libsoptthosttraderapi_se.so"  )
	    add_definitions(-DCTP_V3_6_3=1)	 	

	    
	else ()
		set(CTPOPTION_VERSION           "3.5.8" )
	    set(CTPOPTION_INCLUDE_DIRS      "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8" )
	    set(CTPOPTION_LIBRARY           "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8/libsoptthostmduserapi_se.so" "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8/libsoptthosttraderapi_se.so"  )
	    set(CTPOPTION_LIBRARY_1         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8/libsoptthostmduserapi_se.so"  )
	    set(CTPOPTION_LIBRARY_2         "${THIRDPARTY_PATH}/finctp/option/traderapi_3_5_8/libsoptthosttraderapi_se.so"  )
	    add_definitions(-DCTPOPTION_V3_5_8=1)	
	    
	endif ()
    
endif (CTPOPTION)


############################################################################################################################################################   
## HIREDIS 
## 
############################################################################################################################################################  

if (HIREDIS)
    
    set(HIREDIS_INCLUDE_DIRS       "/usr/local/include"  )    
    set(HIREDIS_LIBRARY            "/usr/local/lib/libhiredis.so"  ) 
    
	if (NOT EXISTS "${THIRDPARTY_PATH}/hiredis/libhiredis.so" )
	
	    ExternalProject_Add(ADD_redis              
            SOURCE_DIR ${THIRDPARTY_PATH}/hiredis
           	CONFIGURE_COMMAND ${CMAKE_COMMAND} .  -DCMAKE_BUILD_TYPE=Release
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make VERBOSE=1
            INSTALL_COMMAND make  install
            )              
	endif()

endif (HIREDIS)

############################################################################################################################################################   
## REDISPLUS 
## 
############################################################################################################################################################  

if (REDISPLUS)
    
    set(REDISPLUS_INCLUDE_DIRS     "/usr/local/include"  )    
    set(REDISPLUS_LIBRARY          "/usr/local/lib/libredis++.so"  ) 
    
	if (NOT EXISTS "${THIRDPARTY_PATH}/redis-plus-plus/libredis++.so" )
	
	    ExternalProject_Add(ADD_redisplus              
            SOURCE_DIR ${THIRDPARTY_PATH}/redis-plus-plus  
           	CONFIGURE_COMMAND ${CMAKE_COMMAND} .
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make VERBOSE=1
            INSTALL_COMMAND make  install
            )              
	endif()

endif (REDISPLUS)

############################################################################################################################################################   
## mysqlclient 
## 
############################################################################################################################################################  

if (MYSQLCLIENT)
    
    set(MYSQLCLIENT_INCLUDE_DIRS       "/usr/local/mysql/include"  )    
    set(MYSQLCLIENT_LIBRARY            "/usr/local/mysql/lib/libmysqlclient.so"  )   

     ExternalProject_Add(ADD_mysqlclient
                URL ${THIRDPARTY_PATH}/zip/mysql-connector-c-6.1.11-src.fixed.tar.gz
                DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
                PREFIX ${CMAKE_BINARY_DIR}
                INSTALL_DIR ${CMAKE_SOURCE_DIR}
                CONFIGURE_COMMAND ${CMAKE_COMMAND} .   -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DDISABLE_SHARED=0
                SOURCE_DIR ${CMAKE_BINARY_DIR}/src/mysql-lib
                BUILD_IN_SOURCE 1
                BUILD_COMMAND make mysqlclient
                INSTALL_COMMAND make  install
                URL_MD5 3578d736b9d493eae076a67e3ed473eb
                )

endif (MYSQLCLIENT)


############################################################################################################################################################   
## mysql++ 
## 
############################################################################################################################################################  

if (MYSQLPP)
    
    set(MYSQLPP_INCLUDE_DIRS        "/usr/local/include/mysql++"  )    
    set(MYSQLPP_LIBRARY             "/usr/local/lib/libmysqlpp.so"  )     
	
	
	    ExternalProject_Add(ADD_mysqlpp              
            	URL ${THIRDPARTY_PATH}/zip/mysql++-3.3.0.tar.gz
                DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
                PREFIX ${CMAKE_BINARY_DIR}
                INSTALL_DIR ${CMAKE_SOURCE_DIR}
                CONFIGURE_COMMAND ./configure
                SOURCE_DIR ${CMAKE_BINARY_DIR}/src/mysqlpp-lib
                BUILD_IN_SOURCE 1
                BUILD_COMMAND make 
                INSTALL_COMMAND make  install
                URL_MD5 39932f1efb6fec00366cd7c7c4bb0914
            )              

endif (MYSQLPP)

############################################################################################################################################################   
## cpr 
## 
############################################################################################################################################################  

if (CPR)
    
    set(CPR_INCLUDE_DIRS     "/usr/local/include"  )    
    set(CPR_LIBRARY          "/usr/local/lib/libcpr.so"  ) 
    
	if (NOT EXISTS "${THIRDPARTY_PATH}/cpr/libcpr.so" )
	
	    ExternalProject_Add(ADD_cpr              
            SOURCE_DIR ${THIRDPARTY_PATH}/cpr
           	CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_BUILD_TYPE=Release
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make VERBOSE=1
            INSTALL_COMMAND make  install
            )              
	endif()

endif (CPR)

############################################################################################################################################################   
## message 
## 
############################################################################################################################################################  
message("----------------------------------------------------")
message("ZLIB:                         zlib | Find(${ZLIB_FOUND}) ")
message("ZLIB_INCLUDE_DIRS:            ${ZLIB_INCLUDE_DIRS} ")
message("ZLIB_LIBRARY:                 ${ZLIB_LIBRARY} ")
message("----------------------------------------------------")
message("CURL:                         curl | Find(${CURL_FOUND}) ")
message("CURL_INCLUDE_DIRS:            ${CURL_INCLUDE_DIRS} ")
message("CURL_LIBRARY:                 ${CURL_LIBRARY} ")
message("----------------------------------------------------")
message("PROTOBUF:                     protobuff | Find(${PROTOBUF_FOUND}) ")
message("PROTOBUF_INCLUDE_DIRS:        ${PROTOBUF_INCLUDE_DIRS}")
message("PROTOBUF_LIBRARY:             ${PROTOBUF_LIBRARY}")
message("----------------------------------------------------")
message("TARSCPP:                      TarsCpp | ${TARSCPP} ")
message("TARSCPP_INCLUDE_DIRS:         ${TARSCPP_INCLUDE_DIRS}")
message("TARSCPP_LIBRARY:              ${TARSCPP_LIBRARY}")
message("----------------------------------------------------")
message("JSONCPP:                      jsoncpp | ${JSONCPP} ")
message("JSONCPP_INCLUDE_DIRS:         ${JSONCPP_INCLUDE_DIRS}")
message("JSONCPP_LIBRARY:              ${JSONCPP_LIBRARY}")
message("----------------------------------------------------")
message("RANDOM:                       random | ${RANDOM} ")
message("RANDOM_INCLUDE_DIRS:          ${RANDOM_INCLUDE_DIRS}")
message("RANDOM_LIBRARY:               ${RANDOM_LIBRARY}")
message("----------------------------------------------------")
message("TINYXML2:                     tinyxml2 | ${TINYXML2} ")
message("TINYXML2_INCLUDE_DIRS:        ${TINYXML2_INCLUDE_DIRS}")
message("TINYXML2_LIBRARY:             ${TINYXML2_LIBRARY}")
message("----------------------------------------------------")
message("FMT:                          fmt | ${FMT} ")
message("FMT_INCLUDE_DIRS:             ${FMT_INCLUDE_DIRS}")
message("FMT_LIBRARY:                  ${FMT_LIBRARY}")
message("----------------------------------------------------")
message("PCCL:                         pccl | ${PCCL} ")
message("PCCL_INCLUDE_DIRS:            ${PCCL_INCLUDE_DIRS}")
message("PCCL_LIBRARY:                 ${PCCL_LIBRARY}")
message("----------------------------------------------------")
message("CTPOPTION:                    ctpoption | ${CTPOPTION} ")
message("CTPOPTION_INCLUDE_DIRS:       ${CTPOPTION_INCLUDE_DIRS}")
message("CTPOPTION_LIBRARY:            ${CTPOPTION_LIBRARY}")
message("----------------------------------------------------")
message("HIREDIS:                      hiredis | ${HIREDIS} ")
message("HIREDIS_INCLUDE_DIRS:         ${HIREDIS_INCLUDE_DIRS}")
message("HIREDIS_LIBRARY:              ${HIREDIS_LIBRARY}")
message("----------------------------------------------------")
message("REDISPLUS:                    redis++ | ${REDISPLUS} ")
message("REDISPLUS_INCLUDE_DIRS:       ${REDISPLUS_INCLUDE_DIRS}")
message("REDISPLUS_LIBRARY:            ${REDISPLUS_LIBRARY}")
message("----------------------------------------------------")
message("MYSQLCLIENT:                  mysqlclient| ${MYSQLCLIENT} ")
message("MYSQLCLIENT_INCLUDE_DIRS:     ${MYSQLCLIENT_INCLUDE_DIRS}")
message("MYSQLCLIENT_LIBRARY:          ${MYSQLCLIENT_LIBRARY}")
message("----------------------------------------------------")
message("MYSQLPP:                      mysql++ | ${MYSQLPP} ")
message("MYSQLPP_INCLUDE_DIRS:         ${MYSQLPP_INCLUDE_DIRS}")
message("MYSQLPP_LIBRARY:              ${MYSQLPP_LIBRARY}")
message("----------------------------------------------------")
message("CPR:                          cpr | ${CPR} ")
message("CPR_INCLUDE_DIRS:             ${CPR_INCLUDE_DIRS}")
message("CPR_LIBRARY:                  ${CPR_LIBRARY}")
message("----------------------------------------------------")







