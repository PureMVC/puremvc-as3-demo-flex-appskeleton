/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.view
{
    import org.puremvc.as3.multicore.interfaces.*;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	 
    import org.puremvc.as3.demos.flex.appskeleton.*;
    import org.puremvc.as3.demos.flex.appskeleton.model.*;
    import org.puremvc.as3.demos.flex.appskeleton.view.components.*;
    
    /**
     * A Mediator for interacting with the top level Application.
     * 
     * <P>
     * In addition to the ordinary responsibilities of a mediator
     * the MXML application (in this case) built all the view components
     * and so has a direct reference to them internally. Therefore
     * we create and register the mediators for each view component
     * with an associated mediator here.</P>
     * 
     * <P>
     * Then, ongoing responsibilities are: 
     * <UL>
     * <LI>listening for events from the viewComponent (the application)</LI>
     * <LI>sending notifications on behalf of or as a result of these 
     * events or other notifications.</LI>
     * <LI>direct manipulating of the viewComponent by method invocation
     * or property setting</LI>
     * </UL>
     */
    public class ApplicationMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "ApplicationMediator";
        
		// available values for the main viewstack
		// defined as contants to help uncover errors at compile time instead of run time
		public static const SPLASH_SCREEN : Number 	=	1;
		public static const MAIN_SCREEN : Number 	=	2;
        
        /**
         * Constructor. 
         * 
         * <P>
         * On <code>applicationComplete</code> in the <code>Application</code>,
         * the <code>ApplicationFacade</code> is initialized and the 
         * <code>ApplicationMediator</code> is created and registered.</P>
         * 
         * <P>
         * The <code>ApplicationMediator</code> constructor also registers the 
         * Mediators for the view components created by the application.</P>
         * 
         * @param object the viewComponent (the ApplicationSkeleton instance in this case)
         */
        public function ApplicationMediator( viewComponent:AppSkeleton ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
		}
		
        override public function onRegister():void
        {
            // Create and register Mediators
            // components that were instantiated by the mxml application 
			facade.registerMediator( new SplashScreenMediator( app.splashScreen ) );
			facade.registerMediator( new MainScreenMediator( app.mainScreen ) );
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
						ApplicationFacade.VIEW_SPLASH_SCREEN,
						ApplicationFacade.VIEW_MAIN_SCREEN
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
				case ApplicationFacade.VIEW_SPLASH_SCREEN:
					app.vwStack.selectedIndex = SPLASH_SCREEN;
					break;

				case ApplicationFacade.VIEW_MAIN_SCREEN:
					app.vwStack.selectedIndex = MAIN_SCREEN;
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
         * @return app the viewComponent cast to AppSkeleton
         */
        protected function get app():AppSkeleton
		{
            return viewComponent as AppSkeleton
        }
    }
}