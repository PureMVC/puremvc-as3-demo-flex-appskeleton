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
		public static const NAME:String = "StartupMonitorProxy";
		// array for store all the resource to read
		private var resourceList:Array;
		// total resource to read 
		private var totalReources:int = 0;
		// number of loaded resources
		private var loadedReources:int = 0;
		
		public function StartupMonitorProxy ( data:Object = null ) 
        {
            super ( NAME, data );
			this.resourceList = new Array();
        }
		
		
		/**
         * Add a resource to load
		 * 
         * @param name proxy name
         * @param blockChain if the load process is stopped until this resource is loaded
         */
		public function addResource( proxyName:String, blockChain:Boolean = false ):void
		{
			this.resourceList.push( new ResourceVO( proxyName, blockChain ) );
		}
		
		/**
         * Start to read all resources
         */
		public function loadResources():void
		{
			for( var i:int = 0; i < this.resourceList.length; i++)
			{
				var r:ResourceVO = this.resourceList[i] as ResourceVO;
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
			for( var i:int = 0; i < this.resourceList.length; i++)
			{
				var r:ResourceVO = this.resourceList[i] as ResourceVO;
				if ( r.proxyName == proxyName )
				{
					r.loaded = true;
					this.loadedReources++;
					// send the notification for update the progress bar
					this.sendNotification( ApplicationFacade.LOADING_STEP, this.resourceList.length / this.loadedReources * 100 );
					// check if the process is completed
					// if is not completed and the resources have blocked the process chain
					// continue to read the other resources
					if ( !this.checkResources() && r.blockChain )
					{
						this.loadResources();
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
			for( var i:int = 0; i < this.resourceList.length; i++)
			{
				var r:ResourceVO = this.resourceList[i] as ResourceVO;
				if ( !r.loaded )
				{
					return false;
				}
			}
			this.sendNotification( ApplicationFacade.LOADING_COMPLETE );
			return true;
		}
	}
}