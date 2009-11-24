/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton
{
    import org.puremvc.as3.multicore.interfaces.*;
    import org.puremvc.as3.multicore.patterns.proxy.*;
    import org.puremvc.as3.multicore.patterns.facade.*;
	import org.puremvc.as3.multicore.patterns.observer.Notification;

    import org.puremvc.as3.demos.flex.appskeleton.view.*;
    import org.puremvc.as3.demos.flex.appskeleton.model.*;
    import org.puremvc.as3.demos.flex.appskeleton.controller.*;

    /**
     * A concrete <code>Facade</code> for the <code>ApplicationSkeleton</code> application.
     * <P>
     * The main job of the <code>ApplicationFacade</code> is to act as a single 
     * place for mediators, proxies and commands to access and communicate
     * with each other without having to interact with the Model, View, and
     * Controller classes directly. All this capability it inherits from 
     * the PureMVC Facade class.</P>
     * 
     * <P>
     * This concrete Facade subclass is also a central place to define 
     * notification constants which will be shared among commands, proxies and
     * mediators, as well as initializing the controller with Command to 
     * Notification mappings.</P>
     */
    public class ApplicationFacade extends Facade
    {
		// Application name
		public static const NAME:String = "AppSkeleton";
				
        // Notification name constants
		// application
        public static const STARTUP:String 					= "startup";
        public static const SHUTDOWN:String 				= "shutdown";

		// command
        public static const COMMAND_STARTUP_MONITOR:String	= "StartupMonitorCommand";
		
		// view
		public static const VIEW_SPLASH_SCREEN:String		= "viewSplashScreen";
		public static const VIEW_MAIN_SCREEN:String			= "viewMainScreen";
		

		public function ApplicationFacade( key:String )
        {
            super(key);    
        }
		
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : ApplicationFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new ApplicationFacade( key );
            return instanceMap[ key ] as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController(); 
            registerCommand( STARTUP, ApplicationStartupCommand );
        }
		
		/**
         * Retrieve the config proxy 
         */
		public static function getConfigProxy():ConfigProxy
		{
			return ConfigProxy( ApplicationFacade.getInstance( ApplicationFacade.NAME ).retrieveProxy( ConfigProxy.NAME ) );
		}
    
		/**
		 * Start the application
		 */
		public function startup( app:AppSkeleton ):void
		{
			sendNotification( STARTUP, app );
		}
		
    }
}