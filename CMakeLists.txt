#################################################### 
## project 
## 
####################################################
cmake_minimum_required (VERSION 3.0)
project (pccl-rpc-framework) 


####################################################
## third library
## 
####################################################

include("${PROJECT_SOURCE_DIR}/cmake/BuildFunction.cmake")
include("${PROJECT_SOURCE_DIR}/cmake/Common.cmake")
include("${PROJECT_SOURCE_DIR}/cmake/Thirdparty.cmake")


####################################################
## add dir
## 
####################################################

add_subdirectory(example)




