
file(GLOB_RECURSE  GLOBAL_SOURCES "*.cpp" "*.h" )

set(PROGRAM "HelloWorldApi")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(${PROGRAM} ${GLOBAL_SOURCES})

include_directories("./"  
					"./api"
					"./config"
					"${PCCL_INCLUDE_DIRS}"
					"${TARSCPP_INCLUDE_DIRS}"
					"${JSONCPP_INCLUDE_DIRS}"
					"${CPR_INCLUDE_DIRS}"
					)


target_link_libraries(${PROGRAM} 
					  ${PCCL_LIBRARY}					  
					  ${TARSCPP_LIBRARY}	
					  ${JSONCPP_LIBRARY}
					  ${CPR_LIBRARY}
					  dl
			    	  pthread	
					 )


install(TARGETS  ${PROGRAM}                     DESTINATION  ${CMAKE_SOURCE_DIR}/build/k8s/TunnelAgent/bin/ )	

