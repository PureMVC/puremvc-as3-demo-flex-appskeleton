/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.model
{
	import mx.rpc.IResponder;

	import org.puremvc.interfaces.*;
    import org.puremvc.patterns.proxy.Proxy;
	
	import org.puremvc.as3.demos.flex.appskeleton.*;
	import org.puremvc.as3.demos.flex.appskeleton.model.business.LoadXMLDelegate;
	import org.puremvc.as3.demos.flex.appskeleton.model.helpers.XmlResource;

    /**
     * A proxy for read the resource file
     */
    public class LocaleProxy extends Proxy implements IProxy, IResponder
    {
		public static const NAME:String = "LocaleProxy";
		// error message
		public var errorStatus:String;
		// StartupMonitorProxy
		private var startupMonitorProxy:StartupMonitorProxy ;
		
		public function LocaleProxy ( data:Object = null ) 
        {
            super ( NAME, data );
			
			// retrieve the StartupMonitorProxy
			this.startupMonitorProxy = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			// add the resource to load
			this.startupMonitorProxy.addResource( LocaleProxy.NAME );
        }
		
		public function load():void
		{
			var configProxy:ConfigProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
			var url:String = configProxy.getValue('language')+'.xml';
			this.data = new Object();
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : LoadXMLDelegate = new LoadXMLDelegate(this, url);
			// make the delegate do some work
			delegate.load();
		}
		
		// this is called when the delegate receives a result from the service
		public function result( rpcEvent : Object ) : void
		{
			// call the helper class for parse the XML data
			XmlResource.parse(data, rpcEvent.result);
			
			// call the StartupMonitorProxy for notify that the resource is loaded
			this.startupMonitorProxy.resourceComplete( LocaleProxy.NAME );
		}
		
		// this is called when the delegate receives a fault from the service
		public function fault( rpcEvent : Object ) : void 
		{
			// store the error message
			this.errorStatus = ApplicationFacade.ERROR_LOAD_FILE;
			// send the failed notification
			sendNotification( ApplicationFacade.LOAD_RESOURCE_FAILED, ApplicationFacade.ERROR_LOAD_FILE );
		}

		/**
         * Get the localized text
		 * 
         * @param key the key to read 
         * @return String the text value stored in internal object
         */
		public function getText(key:String):String
		{
			return data[key.toLowerCase()];
		}
	}
}