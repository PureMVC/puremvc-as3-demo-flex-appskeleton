/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.model
{
	import mx.rpc.IResponder;

	import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.proxy.Proxy;
	
	import org.puremvc.as3.demos.flex.appskeleton.*;
	import org.puremvc.as3.demos.flex.appskeleton.model.business.LoadXMLDelegate;
	import org.puremvc.as3.demos.flex.appskeleton.model.helpers.XmlResource;
	
    /**
     * A proxy for read the config file
     */
    public class ConfigProxy extends Proxy implements IProxy, IResponder
    {
		public static const NAME:String = "ConfigProxy";

		public function ConfigProxy ( data:Object = null ) 
        {
            super ( NAME, data );
			
			// retrieve the StartupMonitorProxy
			startupMonitorProxy = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			// add the resource to load
			startupMonitorProxy.addResource( ConfigProxy.NAME, true );
        }
		
		public function load():void
		{
			// reset the data 
			this.data = new Object();
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : LoadXMLDelegate = new LoadXMLDelegate(this, 'assets/config.xml');
			// make the delegate do some work
			delegate.load();
		}
		
		// this is called when the delegate receives a result from the service
		public function result( rpcEvent : Object ) : void
		{
			// call the helper class for parse the XML data
			XmlResource.parse(data, rpcEvent.result);
			
			// call the StartupMonitorProxy for notify that the resource is loaded
			this.startupMonitorProxy.resourceComplete( ConfigProxy.NAME );
		}
		
		// this is called when the delegate receives a fault from the service
		public function fault( rpcEvent : Object ) : void 
		{
			// send the failed notification
			this.sendNotification( ApplicationFacade.LOAD_CONFIG_FAILED, ApplicationFacade.ERROR_LOAD_FILE );
		}
		
		/**
         * Get the config value
		 * 
         * @param key the key to read 
         * @return String the key value stored in internal object
         */
		public function getValue(key:String):String
		{
			return data[key.toLowerCase()];
		}

		private var startupMonitorProxy:StartupMonitorProxy ;
		
	}
}