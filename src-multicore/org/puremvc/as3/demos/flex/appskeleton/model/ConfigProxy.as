/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.model
{
	import mx.rpc.IResponder;

	import org.puremvc.as3.multicore.interfaces.*;
    import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	import org.puremvc.as3.demos.flex.appskeleton.*;
	import org.puremvc.as3.demos.flex.appskeleton.model.business.LoadXMLDelegate;
	import org.puremvc.as3.demos.flex.appskeleton.model.helpers.XmlResource;
	
    /**
     * A proxy for read the config file
     */
    public class ConfigProxy extends Proxy implements IProxy, IResponder
    {
		public static const NAME:String = "ConfigProxy";									// Proxy name
		public static const SEPARATOR:String = "/";
		
		// Notifications constansts
		public static const LOAD_SUCCESSFUL:String 	= NAME + "loadSuccessful";				// Successful notification
		public static const LOAD_FAILED:String 		= NAME + "loadFailed";					// Failed notification
		
		// Messages
		public static const ERROR_LOAD_FILE:String	= "Could Not Load the Config File!";	// Error message

		private var startupMonitorProxy:StartupMonitorProxy;								// StartupMonitorProxy instance

		public function ConfigProxy ( data:Object = null ) 
        {
            super ( NAME, data );
        }
		
		override public function onRegister():void
		{		
			// retrieve the StartupMonitorProxy
			startupMonitorProxy = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			// add the resource to load
			startupMonitorProxy.addResource( ConfigProxy.NAME, true );
			
			// reset the data 
			setData( new Object() );			
		}
		
		/*
		 * Load the xml file, this method is called by StartupMonitorProxy
		 */
		public function load():void
		{
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : LoadXMLDelegate = new LoadXMLDelegate(this, 'assets/config.xml');
			// make the delegate do some work
			delegate.load();
		}
		
		/*
		 * This is called when the delegate receives a result from the service
		 * 
         * @param rpcEvent
		 */
		public function result( rpcEvent : Object ) : void
		{
			// call the helper class for parse the XML data
			XmlResource.parse(data, rpcEvent.result);
			
			// call the StartupMonitorProxy for notify that the resource is loaded
			startupMonitorProxy.resourceComplete( ConfigProxy.NAME );
			
			// send the successful notification
			sendNotification( ConfigProxy.LOAD_SUCCESSFUL );
		}
		
		/*
		 * This is called when the delegate receives a fault from the service
		 * 
         * @param rpcEvent
		 */
		public function fault( rpcEvent : Object ) : void 
		{
			// send the failed notification
			sendNotification( ConfigProxy.LOAD_FAILED, ConfigProxy.ERROR_LOAD_FILE );
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
		
		/**
         * Get the config numeric value 
		 * 
         * @param key the key to read 
         * @return Number the key value stored in internal object
         */
		public function getNumber(key:String):Number
		{
			return Number( data[key.toLowerCase()] );
		}
		
		/**
         * Get the config boolean value 
		 * 
         * @param key the key to read 
         * @return Boolean the key value stored in internal object
         */
		public function getBoolean(key:String):Boolean
		{
			return data[key.toLowerCase()] ? data[key.toLowerCase()].toLowerCase() == "true" : false;
		}
		
		
		/**
         * Set the config value if isn't defined
		 * 
         * @param key the key to set
         * @param value the value
         */
		public function setDefaultValue( key:String, value:Object ):void
		{
			if ( !data[key.toLowerCase()] )
			{
				data[key.toLowerCase()] = value;
			}
		}
	}
}