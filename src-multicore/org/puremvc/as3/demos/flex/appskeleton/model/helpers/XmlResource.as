/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.appskeleton.model.helpers
{
	public class XmlResource
	{
		static public function parse(data:Object, node:Object, prefix:String=''):void
		{
			for(var i:Number=0;i<node.childNodes.length;i++)
			{
				var currentNode:Object = node.childNodes[i];
				if (currentNode.nodeName=='param' || currentNode.nodeName=='item')
				{
					if (currentNode.attributes.value!=null)
						data[(prefix+currentNode.attributes.name).toLowerCase()] = currentNode.attributes.value;
					else
						data[(prefix+currentNode.attributes.name).toLowerCase()] = currentNode.firstChild.nodeValue;		
				}
				else if (currentNode.nodeName=='group' && currentNode.hasChildNodes())
				{
					XmlResource.parse(data, currentNode, prefix+currentNode.attributes.name+'/');	
					continue;
				}
				if (currentNode.hasChildNodes()) XmlResource.parse(data, currentNode, prefix);
			}
		}
	}
}
