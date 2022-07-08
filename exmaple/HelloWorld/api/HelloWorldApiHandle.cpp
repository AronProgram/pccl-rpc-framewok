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



#include "HelloWorldApiHandle.h"
#include <cpr/cpr.h>
#include "json.h"
#include "BaseRpcPlus.h"
#include "GlobalOption.h"
#include <string>


HelloWorldApiHandle::HelloWorldApiHandle()
{

}


HelloWorldApiHandle::~HelloWorldApiHandle()
{

}

void HelloWorldApiHandle::reset()
{
	TunnelHttpApiHandler::reset();

	_account = "";
}


int  HelloWorldApiHandle::doCheckParams(void)
{

	Json::Value& json    = const_cast<Json::Value&>( this->getBasePointerRef().getDoc()   );
	
	if ( !json.isMember("account_id") ||  !json["account_id"].isString()  )
	{
		TLOG_ERROR("not account_id" << std::endl );
		return pccl::STATE_ERROR;
	}

	_account = json["account_id"].asString();
	
	return pccl::STATE_SUCCESS;
}


int  HelloWorldApiHandle::doProcessWork(void)
{	
	int result = pccl::STATE_SUCCESS;

	result = doLogic();	

	return result;
}


int 	HelloWorldApiHandle::doLogic()
{	
	Json::Value& json    = const_cast<Json::Value&>( this->getBasePointerRef().getDoc()   );
	std::string& route   = const_cast<std::string&>( this->getBasePointerRef().getRoute() );
	
	std::string  remote  = getRemoteAddr(_account);
	std::string  body    = Json::FastWriter().write(json);
	std::string  url     = remote + route ;

	TLOG_DEBUG("account:" << _account << ",url:" << url  << std::endl );
	
	cpr::Response r = cpr::Post( cpr::Url{url}, cpr::Body{body} );	
	if ( r.status_code == 200  )
	{	
		this->direct( r.text );
	}
	else
	{
		this->success(r.text);
	}
	
	return pccl::STATE_SUCCESS;
	
}


std::string  HelloWorldApiHandle::getRemoteAddr(const std::string& account)
{
	AccountOption& option =  GlobalOption::getInstance()->getAccountOption();
	return option[account];
}


