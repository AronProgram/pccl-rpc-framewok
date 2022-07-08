/**
 * Minzea is pleased to support the open source community by making Tars available.
 *
 * Copyright (C) 2016THL A29 Limited, a Tencent company. All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use this file except 
 * in compliance with the License. You may obtain a copy of the License at
 *
 * https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software distributed 
 * under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the 
 * specific language governing permissions and limitations under the License.
 */



#include "HelloWorldApi.h"
#include "HelloWorldApiHandle.h"  


HelloWorldApi::HelloWorldApi(void) 
{
	
}
  

HelloWorldApi::~HelloWorldApi()
{  
	
}


void HelloWorldApi::reset() 
{
	TunnelHttpApiController::reset();
}


void HelloWorldApi::initRoute(void)
{	
	// user
	regiterRoute("/api/helloworld/hello",       new HelloWorldApiHandle(),     pccl::BaseRpcRoute::HTTP_REQUEST_GET     );	
	regiterRoute("/api/helloworld/world",       new HelloWorldApiHandle(),     pccl::BaseRpcRoute::HTTP_REQUEST_POST    );	
	
	
}

void HelloWorldApi::initError(void)
{	
		
}


void HelloWorldApi::doOutput(void)
{

	int code = getCode();

	// 错误处理
	if ( code != 0 )
	{	
		errorResponse();			
	}		

	// 把response输出到client
	std::vector<char>& buffer	= getOutBuffer();
	const std::string& response = getResponse();
		
	buffer.clear();
	buffer.resize( response.length() );	
	memcpy( buffer.data(), response.c_str(), response.length() );	
	
	
}


void	HelloWorldApi::errorResponse()
{
	tars::TC_HttpResponse http;
		
	http.setHeader("Content-Type","application/json;charset=utf-8");			

	int         status = 200;
	std::string body   = getErrorResponse();
	std::string about  = "OK";
	http.setResponse(status,about,body);
	std::string content = http.encode();
	setResponse(content);
}	





