/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.controller
{

    import org.puremvc.interfaces.*;
    import org.puremvc.patterns.command.*;
    import org.puremvc.patterns.observer.*;
    
    import org.puremvc.as3.demos.flex.appskeleton.*;
    import org.puremvc.as3.demos.flex.appskeleton.model.*;
    
    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
     */
    public class ModelPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void    
		{
            facade.registerProxy(new StartupMonitorProxy());
            facade.registerProxy(new ConfigProxy());
            facade.registerProxy(new LocaleProxy());
        }
    }
}