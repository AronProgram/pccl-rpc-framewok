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

#include "HttpServer.h"
#include "RpcControllerImplement.h"
#include "HelloWorldApi.h"
#include "GlobalOption.h"
#include <string>


using namespace std;
using namespace tars;

 


HttpServer::HttpServer(void):pccl::BaseRpcServer("HelloWorldApiObj")
{
	
	
}

void HttpServer::initialize()
{

    // init:
	GlobalOption::getInstance()->init();
	
	// config
    addServant< pccl::RpcControllerImplement< HelloWorldApi > >(ServerConfig::Application + "." + ServerConfig::ServerName + "." + _objName );
    addServantProtocol(ServerConfig::Application + "." + ServerConfig::ServerName + "."  +  _objName,&HttpServer::checkRpcPacket);

	// new method
	addAcceptCallback(std::bind(&HttpServer::onNewClient, this, std::placeholders::_1));
}

void HttpServer::destroyApp()
{
    //destroy application here:
    //...
}

tars::TC_NetWorkBuffer::PACKET_TYPE HttpServer::checkRpcPacket(tars::TC_NetWorkBuffer& in, std::vector<char>& out)
{		
	return tars::TC_NetWorkBuffer::parseHttp(in,out);
}




