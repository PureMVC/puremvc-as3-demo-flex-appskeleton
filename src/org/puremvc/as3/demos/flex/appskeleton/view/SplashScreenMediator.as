/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.view
{
	import flash.events.Event;
	
	import org.puremvc.as3.demos.flex.appskeleton.ApplicationFacade;
	import org.puremvc.as3.demos.flex.appskeleton.model.*;
	import org.puremvc.as3.demos.flex.appskeleton.view.components.*;
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;

    /**
     * A Mediator for interacting with the EmployeeLogin component.
     */
    public class SplashScreenMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "SplashScreenMediator";
        
        /**
         * Constructor. 
         */
        public function SplashScreenMediator( viewComponent:SplashScreen ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
			
			splashScreen.addEventListener(SplashScreen.EFFECT_END, this.endEffect);
        }

        /**
         * List all notifications this Mediator is interested in.
         * <P>
         * Automatically called by the framework when the mediator
         * is registered with the view.</P>
         * 
         * @return Array the list of Nofitication names
         */
        override public function listNotificationInterests():Array 
        {
            return [ 
					ApplicationFacade.LOADING_STEP,
					ApplicationFacade.LOADING_COMPLETE,
					ApplicationFacade.LOAD_CONFIG_FAILED,
					ApplicationFacade.LOAD_RESOURCE_FAILED
					];
        }

        /**
         * Handle all notifications this Mediator is interested in.
         * <P>
         * Called by the framework when a notification is sent that
         * this mediator expressed an interest in when registered
         * (see <code>listNotificationInterests</code>.</P>
         * 
         * @param INotification a notification 
         */
        override public function handleNotification( note:INotification ):void 
        {
            switch ( note.getName() ) 
			{
				case ApplicationFacade.LOADING_STEP:
					// update the progress barr
					this.splashScreen.pb.setProgress( note.getBody() as int, 100);
					break;
					
				case ApplicationFacade.LOADING_COMPLETE:
					// all done
					// show the main screen
					this.sendNotification( ApplicationFacade.VIEW_MAIN_SCREEN );
					break;
					
				case ApplicationFacade.LOAD_CONFIG_FAILED:
				case ApplicationFacade.LOAD_RESOURCE_FAILED:
					// error reading the config XML fille
					// show the error
					this.splashScreen.errorText.text = note.getBody() as String;
					this.splashScreen.errorBox.visible = true;
					break;
            }
        }

        /**
         * Cast the viewComponent to its actual type.
         * 
         * <P>
         * This is a useful idiom for mediators. The
         * PureMVC Mediator class defines a viewComponent
         * property of type Object. </P>
         * 
         * <P>
         * Here, we cast the generic viewComponent to 
         * its actual type in a protected mode. This 
         * retains encapsulation, while allowing the instance
         * (and subclassed instance) access to a 
         * strongly typed reference with a meaningful
         * name.</P>
         * 
         * @return SplashScreen the viewComponent cast to org.puremvc.as3.demos.flex.appskeleton.view.components.SplashScreen
         */
		 
        protected function get splashScreen():SplashScreen
		{
            return viewComponent as SplashScreen;
        }
		
		/**
         * End effect event
         */
		private function endEffect(event:Event=null):void
		{
			// start to load the resources
			var startupMonitorProxy:StartupMonitorProxy = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			startupMonitorProxy.loadResources();
		}
		
    }
}
