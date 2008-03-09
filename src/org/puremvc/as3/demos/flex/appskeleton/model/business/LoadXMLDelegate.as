/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.model.business
{
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class LoadXMLDelegate
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function LoadXMLDelegate( responder : IResponder, url:String) 
		{
			// constructor will store a reference to the service we're going to call
			this.service = new HTTPService();
			this.service.resultFormat = 'xml';
			this.service.url = url;
			
			// and store a reference to the proxy that created this delegate
			this.responder = responder;
		}

		public function load() : void 
		{
			// call the service
			var token:AsyncToken = service.send();
			// notify this responder when the service call completes
			token.addResponder( this.responder );
		}
	}
}