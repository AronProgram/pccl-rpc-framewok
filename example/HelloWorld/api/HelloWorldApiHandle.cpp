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
	HelloWorldHttpApiHandler::reset();

	_content = "";
}


int  HelloWorldApiHandle::doCheckParams(void)
{

	Json::Value& json    = const_cast<Json::Value&>( this->getBasePointerRef().getDoc()   );
	
	if ( !json.isMember("content") ||  !json["content"].isString()  )
	{
		TLOG_ERROR("not account_id" << std::endl );
		return pccl::STATE_ERROR;
	}

	_content = json["content"].asString();
	
	return pccl::STATE_SUCCESS;
}


int  HelloWorldApiHandle::doProcessWork(void)
{	
	int result = pccl::STATE_SUCCESS;

	Json::Value data;

	data["flag"] = "HelloWorld";
	data["text"] = _content;

	this->success(data);

	return result;
}





