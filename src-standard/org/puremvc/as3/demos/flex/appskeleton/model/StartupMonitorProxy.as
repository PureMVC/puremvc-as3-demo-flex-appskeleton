/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.model
{
	import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.proxy.Proxy;
	
	import org.puremvc.as3.demos.flex.appskeleton.*;
	import org.puremvc.as3.demos.flex.appskeleton.model.vo.ResourceVO;
	
    /**
     * A proxy for the startup loading process
	 * code based on Meekgeek suggestion
	 * http://forums.puremvc.org/index.php?topic=21.msg345#msg345
     */
    public class StartupMonitorProxy extends Proxy implements IProxy
    {
		public static const NAME:String = "StartupMonitorProxy";							// Proxy name
		
		// Notifications constansts
		public static const LOADING_STEP:String				= NAME + "loadingStep";			// Notification send when a resource il loaded
		public static const LOADING_COMPLETE:String			= NAME + "loadingComplete";		// Notification send when all the resources are loaded
	   
		private var resourceList:Array;														// array for store all the resource to read
		private var totalReources:int = 0;													// total resource to read 
		private var loadedReources:int = 0;													// number of loaded resources
		
		
		public function StartupMonitorProxy ( data:Object = null ) 
        {
            super ( NAME, data );
			resourceList = new Array();
        }
		
		
		/**
         * Add a resource to load
		 * 
         * @param name proxy name
         * @param blockChain if the load process is stopped until this resource is loaded
         */
		public function addResource( proxyName:String, blockChain:Boolean = false ):void
		{
			resourceList.push( new ResourceVO( proxyName, blockChain ) );
		}
		
		/**
         * Start to read all resources
         */
		public function loadResources():void
		{
			for( var i:int = 0; i < resourceList.length; i++)
			{
				var r:ResourceVO = resourceList[i] as ResourceVO;
				if ( !r.loaded )
				{
					var proxy:* = facade.retrieveProxy( r.proxyName ) as Proxy;
					proxy.load();
					
					// check if the loading process must be stopped until the resource is loaded
					if ( r.blockChain )
					{
						break;
					}
				}
			}
		}
		
		/**
         * The resource is loaded, update the state anche check if the loading process is completed
		 * 
         * @param name proxy name
         */
		public function resourceComplete( proxyName:String ):void
		{
			for( var i:int = 0; i < resourceList.length; i++)
			{
				var r:ResourceVO = resourceList[i] as ResourceVO;
				if ( r.proxyName == proxyName )
				{
					r.loaded = true;
					loadedReources++;
					// send the notification for update the progress bar
					sendNotification( StartupMonitorProxy.LOADING_STEP, (loadedReources * 100) / resourceList.length );
					// check if the process is completed
					// if is not completed and the resources have blocked the process chain
					// continue to read the other resources
					if ( !checkResources() && r.blockChain )
					{
						loadResources();
					}
					break;
				}
			}

		}
	
		/**
         * Check if the loading process is completed
		 * 
         * @return boolean process is completed
         */
		private function checkResources():Boolean
		{
			for( var i:int = 0; i < resourceList.length; i++)
			{
				var r:ResourceVO = resourceList[i] as ResourceVO;
				if ( !r.loaded )
				{
					return false;
				}
			}
			sendNotification( StartupMonitorProxy.LOADING_COMPLETE );
			return true;
		}
	}
}