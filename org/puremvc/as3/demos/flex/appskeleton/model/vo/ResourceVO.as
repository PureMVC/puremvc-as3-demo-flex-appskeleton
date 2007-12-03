/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.model.vo
{
	import org.puremvc.patterns.proxy.Proxy;
	
	public class ResourceVO
	{
		public var proxyName:String;
		public var loaded:Boolean;
		public var blockChain:Boolean;
		
		function ResourceVO( proxyName:String, blockChain:Boolean )
		{
			this.proxyName = proxyName;
			this.loaded = false;
			this.blockChain = blockChain;
		}
	}
	
}
