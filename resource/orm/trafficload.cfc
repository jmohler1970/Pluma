<!---
Copyright © 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->


<cfcomponent persistent="true" table="Traffic" hint="User to load data">
	<cfproperty name="TrafficID" fieldtype="id" generator="identity">
	<cfproperty name="Subsystem" update="false">
	<cfproperty name="Section" update="false">
	<cfproperty name="Item" update="false">
	<cfproperty name="url_vars" update="false">
	<cfproperty name="isPost" update="false" default="false">
	<cfproperty name="Referer" update="false" default="">
	<cfproperty name="Agent" update="false" default="">
	<cfproperty name="http_accept_language" update="false">

	<cfproperty name="xmlGeoLocation" update="false" default="">
		
	<cfproperty name="CreateDate" update="false" generated="always">
</cfcomponent>

