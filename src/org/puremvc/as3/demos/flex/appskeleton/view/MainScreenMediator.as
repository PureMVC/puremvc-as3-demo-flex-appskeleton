/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.view
{
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import org.puremvc.as3.demos.flex.appskeleton.*;
	import org.puremvc.as3.demos.flex.appskeleton.model.*;
	import org.puremvc.as3.demos.flex.appskeleton.view.components.*;

    /**
     * A Mediator for interacting with the EmployeeLogin component.
     */
    public class MainScreenMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "MainScreenMediator";
        
		private var configProxy:ConfigProxy;
		private var localeProxy:LocaleProxy;
		
        /**
         * Constructor. 
         */
        public function MainScreenMediator( viewComponent:MainScreen ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
			
			// retrieve the proxies
			this.configProxy = this.facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
			this.localeProxy = this.facade.retrieveProxy( LocaleProxy.NAME ) as LocaleProxy;
			
			this.mainScreen.addEventListener( MainScreen.CREATION_COMPLETE, this.handleCreationComplete );
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
         * @return MainScreen the viewComponent cast to org.puremvc.as3.demos.flex.appskeleton.view.components.MainScreen
         */
		 
        protected function get mainScreen():MainScreen
		{
            return viewComponent as MainScreen;
        }
		
		/*********************************/
		/* events handler 				 */
		/*********************************/
		
		private function handleCreationComplete( evt:Event ):void
		{
			var myHtmlText:String = '';
			myHtmlText += '<b>simple value:</b> this.configProxy.getValue( \'keyName\' ) = ' + this.configProxy.getValue( 'keyName' ) + '<br><br>';
			myHtmlText += '<b>long text value:</b> this.configProxy.getValue( \'otherKeyName\' ) = ' + this.configProxy.getValue( 'otherKeyName' ) + '<br><br>';
			myHtmlText += '<b>value inside a group:</b> this.configProxy.getValue( \'groupName/keyNameInsideGroup\' ) = ' + this.configProxy.getValue( 'groupName/keyNameInsideGroup' ) + '<br><br>';
			myHtmlText += '<b>value inside neested group:</b> this.configProxy.getValue( \'groupName/subGroupName/keyNameInsideSubGroup\' ) = ' + this.configProxy.getValue( 'groupName/subGroupName/keyNameInsideSubGroup' ) + '<br><br>';
			this.mainScreen.configValueExample.htmlText = myHtmlText;
			
			var myHtmlLocaleText:String = '';
			myHtmlLocaleText += '<b>simple text resource:</b> this.localeProxy.getText( \'keyName\' ) = ' + this.localeProxy.getText( 'Hello world' ) + '<br><br>';
			myHtmlLocaleText += '<b>long text resource:</b> this.localeProxy.getText( \'Long text\' ) = ' + this.localeProxy.getText( 'Long text' ) + '<br>';
			this.mainScreen.localeValueExample.htmlText = myHtmlLocaleText;
		}
    }
}