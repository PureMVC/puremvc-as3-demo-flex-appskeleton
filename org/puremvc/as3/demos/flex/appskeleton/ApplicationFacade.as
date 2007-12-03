/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton
{
    import org.puremvc.interfaces.*;
    import org.puremvc.patterns.proxy.*;
    import org.puremvc.patterns.facade.*;
	import org.puremvc.patterns.observer.Notification;

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
        // Notification name constants
		// application
        public static const APP_STARTUP:String 				= "appStartup";
        public static const APP_SHUTDOWN:String 			= "appShutdown";

		
		// proxy
        public static const LOADING_STEP:String				= "loadingStep";
        public static const LOADING_COMPLETE:String			= "loadingComplete";
		public static const LOAD_CONFIG_FAILED:String		= "loadConfigFailed";
        public static const LOAD_RESOURCE_FAILED:String		= "loadResourceFailed";
		
		// command
        public static const COMMAND_STARTUP_MONITOR:String	= "StartupMonitorCommand";
		
		// view
		public static const VIEW_SPLASH_SCREEN:String		= "viewSplashScreen";
		public static const VIEW_MAIN_SCREEN:String			= "viewMainScreen";
		
		// common messages
		public static const ERROR_LOAD_FILE:String			= "Could Not Load the File!";
		
		/**
		 * Start the application
		 */
		public function startup( app:Object ):void
		{
			notifyObservers ( new Notification( APP_STARTUP,app ) );
		}
		
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade 
		{
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController(); 
            registerCommand( APP_STARTUP, org.puremvc.as3.demos.flex.appskeleton.controller.ApplicationStartupCommand );
        }
		
		/**
         * Retrieve the config proxy 
         */
		public static function getConfigProxy():ConfigProxy
		{
			return ConfigProxy( ApplicationFacade.getInstance().retrieveProxy( ConfigProxy.NAME ) );
		}
    
		/**
         * Retrieve the resource proxy 
         */
		public static function getLocaleProxy():LocaleProxy
		{
			return LocaleProxy( ApplicationFacade.getInstance().retrieveProxy( LocaleProxy.NAME ) );
		}
    }
}