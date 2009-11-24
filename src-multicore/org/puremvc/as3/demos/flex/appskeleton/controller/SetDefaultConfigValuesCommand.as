/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.controller 
{
	import org.puremvc.as3.demos.flex.appskeleton.ApplicationFacade
	import org.puremvc.as3.demos.flex.appskeleton.model.ConfigProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
     * This command set the default values in <code>Config Proxy</code>
     */
	public class SetDefaultConfigValuesCommand extends SimpleCommand
    {
		override public function execute( note:INotification ) :void    
		{
			var configProxy:ConfigProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
			configProxy.setDefaultValue( "language", "en" );
			configProxy.setDefaultValue( "testDefaultValue", "This isn't defined in config.xml but in SetDefaultConfigValuesCommand" );
        }
	}
	
}