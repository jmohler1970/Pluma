/* For: MS SQL 2008 and above */





/* Load the users in here  */
/* Passwords are 'kc' without quotes */

SET ANSI_PADDING ON
GO

SET IDENTITY_INSERT [dbo].[Users] ON 
GO


INSERT [dbo].[Users] ([UserID], [login], [passhash], [PersonName], 
[homepath], [email], [comments], [lastLogin], [ExpirationDate], 
[xmlAbout], [xmlProfile], [xmlContact], [xmlLink], [xmlPref], [xmlGroup], [PrefGroup], DeleteDate, 
[Modified],
[Created]) 

VALUES (1, N'Admin', N'190A4568B2', N'<PersonName xmlns="http://ns.hr-xml.org/2007-04-15"><GivenName>Sally</GivenName><FamilyName>Sys Admin</FamilyName></PersonName>',
NULL, N'', NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, N'<data type="group">System</data>', NULL, NULL, 
N'<message by="James Mohler" date="2013-04-10T20:56:29.177" title="User logged in" ip="" />',
N'<message by="James Mohler" date="2013-04-03T21:52:58.053" title="" ip="127.0.0.1" />')
GO


INSERT [dbo].[Users] ([UserID], [login], [passhash], [PersonName], 
[homepath], [email], [comments], [lastLogin], [ExpirationDate], 
[xmlAbout], [xmlProfile], [xmlContact], [xmlLink], [xmlPref], [xmlGroup], [PrefGroup], DeleteDate, 
[Modified],
[Created]) 

VALUES (2, N'Kate', N'190A4568B2', N'<PersonName xmlns="http://ns.hr-xml.org/2007-04-15"><GivenName>Kate</GivenName><FamilyName>Contributor</FamilyName></PersonName>',
NULL, N'', NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, N'<data type="group">Contributor</data>', NULL, NULL, 
N'<message by="James Mohler" date="2013-04-10T20:56:29.177" title="User logged in" ip="" />',
N'<message by="James Mohler" date="2013-04-03T21:52:58.053" title="" ip="127.0.0.1" />')
GO


INSERT [dbo].[Users] ([UserID], [login], [passhash], [PersonName], 
[homepath], [email], [comments], [lastLogin], [ExpirationDate], 
[xmlAbout], [xmlProfile], [xmlContact], [xmlLink], [xmlPref], [xmlGroup], [PrefGroup], DeleteDate, 
[Modified],
[Created]) 

VALUES (3, N'Mindy', N'190A4568B2', N'<PersonName xmlns="http://ns.hr-xml.org/2007-04-15"><GivenName>Mindy</GivenName><FamilyName>Member</FamilyName></PersonName>',
NULL, N'', NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, N'<data type="group">Member</data>', NULL, NULL, 
N'<message by="James Mohler" date="2013-04-10T20:56:29.177" title="User logged in" ip="" />',
N'<message by="" date="2013-04-03T21:52:58.053" title="" ip="127.0.0.1" />')
GO


INSERT [dbo].[Users] ([UserID], [login], [passhash], [PersonName], 
[homepath], [email], [comments], [lastLogin], [ExpirationDate], 
[xmlAbout], [xmlProfile], [xmlContact], [xmlLink], [xmlPref], [xmlGroup], [PrefGroup], DeleteDate, 
[Modified],
[Created]) 

VALUES (4, N'Elizabeth', N'190A4568B2', N'<PersonName xmlns="http://ns.hr-xml.org/2007-04-15"><GivenName>Elizabeth</GivenName><FamilyName>Expired</FamilyName></PersonName>',
NULL, N'', NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, N'<data type="group">Member</data>', NULL, NULL, 
N'<message by="James Mohler" date="2013-04-10T20:56:29.177" title="User logged in" ip="142.136.11.230" />',
N'<message by="" date="2013-04-03T21:52:58.053" title="" ip="" />')
GO


SET IDENTITY_INSERT [dbo].[Users] OFF
GO



SET ANSI_PADDING ON
GO
SET IDENTITY_INSERT [dbo].[Node] ON 

GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (78, NULL, 0, 1, N'', N'', N'Root', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, N'Active', 0, NULL, NULL, 0, NULL, 0, NULL, NULL, N'<message by="" date="2013-04-03T21:52:58.087" title="Created" ip="142.136.11.230" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (79, 78, 1, 0, N'index', N'<title>Welcome to PlumaCMS</title>', N'Page', N'
<p>	Thank you for using PlumaCMS. This is your homepage, so please change this text to be what you want.</p>

<h2>Header 2</h2>
<p>
	Lorem ipsum <em>dolor sit amet</em>, <strong>consectetur adipiscing elit</strong>. Donec <code>this is code</code> venenatis augue. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer vulputate pretium augue.</p>

<h3>Header 3</h3>
<pre>
<code>#header h1 a { 
	display: block; 
	width: 300px; 
	height: 80px; 
}</code></pre>

<h4>Header 4</h4>
<ol>
	<li>Lorem ipsum dolor sit amet</li>
	<li>Consectetur adipiscing elit</li>
	<li>Donec ut est risus, placerat venenatis augue</li>
</ol>

<blockquote>
	A blockquote. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut est risus, placerat venenatis augue. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
</blockquote>
', NULL, NULL, NULL, N'<menu status="1" sortorder="1">Home</menu>', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 1, NULL, N'<message by="" date="2013-04-03T21:52:58.100" title="Node was updated" ip="142.136.11.230" />', N'<message by="" date="2013-04-03T21:52:58.100" title="Created" ip="142.136.11.230" />')
GO

INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (80, 78, 0, 0, N'search', N'<title>Search</title><subtitle />', N'Page', NULL, NULL, N'<theme_template>search.cfm</theme_template>', NULL, N'<menu status="" sortorder="" />', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="Admin " date="2013-04-03T22:42:31.480" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="" date="2013-04-03T21:52:58.147" title="Created" ip="142.136.11.230" />')
GO

INSERT [dbo].[Node] ([ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (78, 0, 0, N'404', N'<title>404 Error</title><subtitle />', N'Page', NULL, NULL, N'<theme_template>404.cfm</theme_template>', NULL, N'<menu status="" sortorder="" />', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 1, NULL, N'<message by="Admin " date="2013-04-03T22:42:31.480" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="" date="2013-04-03T21:52:58.147" title="Created" ip="142.136.11.230" />')
GO



INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (81, 78, 0, 0, N'tag', N'<title>Tags</title><subtitle />', N'Page', NULL, NULL, N'<theme_template>tag.cfm</theme_template>', NULL, N'<menu status="" sortorder="" />', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="James Mohler" date="2013-04-07T22:45:30.817" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="" date="2013-04-03T21:52:58.193" title="Created" ip="142.136.11.230" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (82, 78, 0, 0, N'grumpy-cat', N'<title>Grumpy Cat</title><subtitle />', N'Page', N'<h2>About</h2>
<p>Grumpy Cat is a nickname given to an angry-looking snowshoe cat that rose to fame online after its pictures were posted to Reddit in late September 2012. The cat is also known as ''Tardar'' which is short for Tardar (Tartar) Sauce.</p>
<h2>Origin</h2>
<p>Grumpy Cat is owned by Arizona resident Tabatha Bundesen. The original photos of Grumpy Cat were posted to the /r/pics subreddit[1] by Bundesen''s brother Bryan on September 23rd, 2012 (shown below).</p>
<p>The Reddit post was instantly met with photoshopped parodies and image macros from others, reaching the front page with more than 25,300 up votes in the first 24 hours. Meanwhile, the Imgur page[13] gained nearly 1,030,000 views in the first 48 hours. The same day, three video clips of the cat playing indoors were uploaded to YouTube by Bundesen the same day.</p>
<h2>Precursor</h2>
<p>The name ''Grumpy Cat'' has been associated with pictures of scornful looking cats prior to this instance, mainly through the LOLcat image macro series X is not amused and Serious Cat.</p>', NULL, N'', NULL, N'<menu status="" sortorder="2">Grumpy Cat</menu><tags>arizona</tags><tags>cat</tags><tags>reddit</tags>', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="James Mohler" date="2013-04-08T00:02:43.133" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="" date="2013-04-03T21:52:58.257" title="Created" ip="142.136.11.230" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (87, 78, 0, 0, N'andorra', N'<title>Andorra–European Union relations</title><subtitle />', N'Page', N'<p>&nbsp;</p>
<h1 id="firstHeading" class="firstHeading" lang="en" style="background-image: none; font-weight: normal; margin: 0px 0px 0.1em; overflow: hidden; padding-top: 0px; padding-bottom: 0px; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(170, 170, 170); font-size: 1.6em; line-height: 1.2em; font-family: sans-serif; ">Andorra&ndash;European Union relations</h1>
<div id="bodyContent">
<div id="siteSub">From Wikipedia, the free encyclopedia</div>
<div id="contentSub">&nbsp;</div>
<div id="jump-to-nav">&nbsp;</div>
<div id="mw-content-text" dir="ltr">
<h2>Customs Union</h2>
<div>Further information:&nbsp;<a href="http://en.wikipedia.org/wiki/European_Union_Customs_Union" title="European Union Customs Union">European Union Customs Union</a></div>
<p>The &quot;Agreement between the&nbsp;<a href="http://en.wikipedia.org/wiki/European_Economic_Community" title="European Economic Community">European Economic Community</a>&nbsp;and the Principality of Andorra&quot; (signed 28 June 1990, entered into force 1 July 1991) establishes a customs union with&nbsp;<a href="http://en.wikipedia.org/wiki/Most_favoured_nation" title="Most favoured nation">most favoured nation</a>&nbsp;status between the Principality and the EU. Andorra is treated as an EU state where trade in manufactured goods is concerned, but not for agricultural produce.<a href="http://en.wikipedia.org/wiki/Andorra%E2%80%93European_Union_relations#cite_note-EEAS_article-1">[1]</a></p>
<p>There are full customs checks on the EU side of the border, as Andorra has low&nbsp;<a href="http://en.wikipedia.org/wiki/VAT" title="VAT">VAT</a>&nbsp;and other indirect taxes, such as those for alcohol, tobacco and petrol, from which visitors might benefit.</p>
<h2>&nbsp;</h2>
</div>
</div>', NULL, N'', NULL, N'<menu status="" sortorder="" /><tags>eu</tags><tags>customs union</tags><tags>history</tags><tags>currency</tags>', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="James Mohler" date="2013-04-10T21:11:29.610" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="Admin " date="2013-04-06T21:28:12.317" title="Created" ip="142.136.11.230" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (90, NULL, 0, 0, N'welcome-to-plumacms', N'', N'Page', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, N'Public', 0, NULL, NULL, 0, NULL, 0, NULL, NULL, N'<message by="" date="2013-04-06T21:40:08.763" title="Created" ip="" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (93, 78, 0, 0, N'african-wildcat', N'<title>African wildcat</title><subtitle />', N'Page', N'<p>&nbsp;</p>
<h1 id="firstHeading">African wildcat</h1>
<div id="bodyContent">
<div id="siteSub">From Wikipedia, the free encyclopedia</div>
<div id="contentSub">&nbsp;</div>
<div id="mw-content-text" dir="ltr">
<p>The&nbsp;African wildcat&nbsp;(Felis silvestris lybica) is a&nbsp;<a href="http://en.wikipedia.org/wiki/Wildcat" title="Wildcat">wildcat</a>&nbsp;<a href="http://en.wikipedia.org/wiki/Subspecies" title="Subspecies">subspecies</a>&nbsp;that occurs across northern&nbsp;<a href="http://en.wikipedia.org/wiki/Africa" title="Africa">Africa</a>&nbsp;and extends around the periphery of the&nbsp;<a href="http://en.wikipedia.org/wiki/Arabian_Peninsula" title="Arabian Peninsula">Arabian Peninsula</a>&nbsp;to the&nbsp;<a href="http://en.wikipedia.org/wiki/Caspian_Sea" title="Caspian Sea">Caspian Sea</a>. As it is the most common and widely distributed wild cat, it is listed as&nbsp;<a href="http://en.wikipedia.org/wiki/Least_Concern" title="Least Concern">Least Concern</a>&nbsp;by&nbsp;<a href="http://en.wikipedia.org/wiki/IUCN" title="IUCN">IUCN</a>&nbsp;since 2002.<a href="http://en.wikipedia.org/wiki/African_wildcat#cite_note-iucn-1">[1]</a></p>
<p>The African wildcat appears to have diverged from the other subspecies about 131,000 years ago.<a href="http://en.wikipedia.org/wiki/African_wildcat#cite_note-Driscoll07-2">[2]</a>&nbsp;Some individual African wildcats were first&nbsp;<a href="http://en.wikipedia.org/wiki/Domestication" title="Domestication">domesticated</a>about 10,000 years ago in the Middle East, and are the ancestors of the&nbsp;<a href="http://en.wikipedia.org/wiki/Domestic_cat" title="Domestic cat">domestic cat</a>. Remains of domesticated cats have been included in human burials as far back as 9,500 years ago in&nbsp;<a href="http://en.wikipedia.org/wiki/Cyprus" title="Cyprus">Cyprus</a>.<a href="http://en.wikipedia.org/wiki/African_wildcat#cite_note-3">[3]</a><a href="http://en.wikipedia.org/wiki/African_wildcat#cite_note-4">[4]</a></p>
</div>
</div>', NULL, N'', NULL, N'<menu status="" sortorder="" /><tags>cat</tags><tags>conservation</tags><tags>domestication</tags><tags>evolution</tags>', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="James Mohler" date="2013-04-10T21:07:04.910" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="Admin " date="2013-04-06T21:48:09.620" title="Created" ip="142.136.11.230" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (94, 78, 0, 0, N'new-amsterdam', N'<title>New Amsterdam</title><subtitle />', N'Page', N'<p>&nbsp;</p>
<h1 id="firstHeading">New Amsterdam</h1>
<div id="bodyContent">
<div id="siteSub">From Wikipedia, the free encyclopedia</div>
<div id="contentSub">&nbsp;</div>
<div id="jump-to-nav">&nbsp;</div>
<div id="mw-content-text" dir="ltr">
<div>This article is about the settlement that became New York City. For other uses, see&nbsp;<a href="http://en.wikipedia.org/wiki/New_Amsterdam_(disambiguation)" title="New Amsterdam (disambiguation)">New Amsterdam (disambiguation)</a>.</div>
<div>
<div><a href="http://en.wikipedia.org/wiki/File:CastelloPlanOriginal.jpg"><img alt="" src="http://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/CastelloPlanOriginal.jpg/220px-CastelloPlanOriginal.jpg" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/e7/CastelloPlanOriginal.jpg/330px-CastelloPlanOriginal.jpg 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/e7/CastelloPlanOriginal.jpg/440px-CastelloPlanOriginal.jpg 2x" /></a>
<div>
<div><a href="http://en.wikipedia.org/wiki/File:CastelloPlanOriginal.jpg" title="Enlarge"><img src="http://bits.wikimedia.org/static-1.21wmf12/skins/common/images/magnify-clip.png" alt="" /></a></div>
The original city map of New Amsterdam called&nbsp;<a href="http://en.wikipedia.org/wiki/Castello_Plan" title="Castello Plan">Castello Plan</a>&nbsp;from 1660<br />
(the bottom left corner is approximately south, while the top right corner is approximately north)</div>
</div>
</div>
</div>
</div>', NULL, N'', NULL, N'<menu status="" sortorder="" /><tags>new york city</tags><tags>history</tags>', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="James Mohler" date="2013-04-10T21:12:01.263" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="Admin " date="2013-04-06T21:54:30.243" title="Created" ip="142.136.11.230" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (96, 78, 0, 0, N'panama-canal-railway', N'<title>Panama Canal Railway</title><subtitle />', N'Page', N'<p>&nbsp;The&nbsp;Panama Canal Railway Company&nbsp;(reporting mark&nbsp;PCRC) is a&nbsp;railway&nbsp;line that links the&nbsp;Atlantic Ocean&nbsp;to the&nbsp;Pacific Ocean&nbsp;across&nbsp;Panamain&nbsp;Central America. It is jointly owned by&nbsp;Kansas City Southern&nbsp;and Mi-Jack Products.[2]&nbsp;The route stretches 47.6 miles (76.6&nbsp;km) across theIsthmus of Panama&nbsp;from&nbsp;Col&oacute;n&nbsp;(Atlantic) to&nbsp;Balboa&nbsp;(Pacific, near&nbsp;Panama City).</p>
<p>The infrastructure of this still-functioning railroad (formerly the&nbsp;Panama Railway&nbsp;or&nbsp;Panama Rail Road) was of vital importance for construction of the&nbsp;Panama Canal&nbsp;over a parallel route half a century later. The principal incentive for the building of the rail line was the vast increase in traffic to California owing to the 1849&nbsp;California Gold Rush. Construction on the Panama Railroad began in 1850 and the first revenue train ran over the full length on January 28, 1855. Referred to as being an&nbsp;inter-oceanic railroad&nbsp;when it opened,[3]&nbsp;it was later also described by some as representing a&nbsp;&quot;transcontinental&quot;&nbsp;railroad despite only transversing the narrow isthmus connecting the&nbsp;North&nbsp;and&nbsp;South Americancontinents.[4][5][6][7]</p>', NULL, N'', NULL, N'<menu status="" sortorder="" /><tags>history</tags><tags>construction</tags><tags>shipping</tags><tags>tracks</tags><tags>layout</tags><tags>services</tags>', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="James Mohler" date="2013-04-10T21:06:17.283" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="Admin " date="2013-04-06T21:56:59.380" title="Created" ip="142.136.11.230" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (97, 78, 0, 0, N'asia-roman-province', N'<title>Asia (Roman Province)</title><subtitle />', N'Page', N'<p>&nbsp;</p>
<h1 id="firstHeading">Asia (Roman province)</h1>
<div id="bodyContent">
<div id="siteSub">&nbsp;</div>
<div id="mw-content-text" dir="ltr">
<div>
<div>
<div>Roman conquest of&nbsp;<a href="http://en.wikipedia.org/wiki/Asia_minor" title="Asia minor">Asia minor</a></div>
</div>
</div>
<p>The&nbsp;Roman province of Asia&nbsp;or&nbsp;Asiana&nbsp;(<a href="http://en.wikipedia.org/wiki/Greek_language" title="Greek language">Greek</a>:&nbsp;&Alpha;&sigma;&iota;&alpha;&nu;?), in&nbsp;<a href="http://en.wikipedia.org/wiki/Byzantine_Empire" title="Byzantine Empire">Byzantine</a>&nbsp;times called&nbsp;<a href="http://en.wikipedia.org/wiki/Phrygia" title="Phrygia">Phrygia</a>, was an administrative unit added to the late&nbsp;<a href="http://en.wikipedia.org/wiki/Roman_Republic" title="Roman Republic">Republic</a>. It was a&nbsp;<a href="http://en.wikipedia.org/wiki/Senatorial_province" title="Senatorial province">Senatorial province</a>&nbsp;governed by a&nbsp;<a href="http://en.wikipedia.org/wiki/Proconsul" title="Proconsul">proconsul</a>. The arrangement was unchanged in the reorganization of the&nbsp;<a href="http://en.wikipedia.org/wiki/Roman_Empire" title="Roman Empire">Roman Empire</a>&nbsp;in 211.</p>
</div>
</div>
<p>&nbsp;</p>', NULL, N'', NULL, N'<menu status="" sortorder="" /><tags>rome</tags><tags>history</tags><tags>geography</tags><tags>military</tags>', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="James Mohler" date="2013-04-10T21:05:44.117" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="Admin " date="2013-04-06T21:58:53.230" title="Created" ip="142.136.11.230" />')
GO
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [Modified], [Created]) VALUES (100, 78, 0, 0, N'albert-einstein', N'<title>Albert Einstein</title><subtitle />', N'Page', N'<p>&nbsp;</p>
<h1 id="firstHeading">Albert Einstein</h1>
<div id="bodyContent">
<div id="siteSub">From Wikipedia, the free encyclopedia</div>
<div id="contentSub">&nbsp;</div>
<div id="mw-content-text" dir="ltr">
<div><br />
Albert Einstein&nbsp;(pron.:&nbsp;/?&aelig;lb?rt&nbsp;?a?nsta?n/;&nbsp;German:&nbsp;[?alb?t ?a?n?ta?n]&nbsp;(<img alt="" src="http://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Speaker_Icon.svg/13px-Speaker_Icon.svg.png" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/2/21/Speaker_Icon.svg/20px-Speaker_Icon.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/2/21/Speaker_Icon.svg/26px-Speaker_Icon.svg.png 2x" />&nbsp;listen); 14 March 1879&nbsp;&ndash; 18 April 1955) was a German-born&nbsp;theoretical physicist&nbsp;who developed the&nbsp;general theory of relativity, one of the two pillars of&nbsp;modern physics&nbsp;(alongside&nbsp;quantum mechanics).[2][3]&nbsp;While best known for his&nbsp;mass&ndash;energy equivalence&nbsp;formula&nbsp;E&nbsp;=&nbsp;mc2&nbsp;(which has been dubbed &quot;the world''s most famous equation&quot;),[4]&nbsp;he received the&nbsp;1921&nbsp;Nobel Prize in Physics&nbsp;&quot;for his services to theoretical physics, and especially for his discovery of the law of the&nbsp;photoelectric effect&quot;.[5]&nbsp;The latter was pivotal in establishing&nbsp;quantum theory.</div>
<p>Near the beginning of his career, Einstein thought that&nbsp;Newtonian mechanics&nbsp;was no longer enough to reconcile the laws of&nbsp;classical mechanics&nbsp;with the laws of the&nbsp;electromagnetic field. This led to the development of his&nbsp;special theory of relativity. He realized, however, that the principle of relativity could also be extended to&nbsp;gravitational fields, and with his subsequent theory of gravitation in 1916, he published a paper on the&nbsp;general theory of relativity. He continued to deal with problems of&nbsp;statistical mechanics&nbsp;and&nbsp;quantum theory, which led to his explanations of&nbsp;particle theory&nbsp;and the&nbsp;motion of molecules. He also investigated the thermal properties of light which laid the foundation of the&nbsp;photon&nbsp;theory of light. In 1917, Einstein applied the general theory of relativity to model the structure of the&nbsp;universe&nbsp;as a whole.[6]</p>
<p>He was visiting the&nbsp;United States&nbsp;when&nbsp;Adolf Hitler&nbsp;came to power in 1933 and did not go back to Germany, where he had been a professor at the&nbsp;Berlin Academy of Sciences. He settled in the U.S., becoming an&nbsp;American citizen&nbsp;in 1940.[7]&nbsp;On the eve of World War II, he helped alert President&nbsp;Franklin D. Roosevelt&nbsp;that Germany might be developing an atomic weapon and recommended that the U.S. begin similar research; this eventually led to what would become the&nbsp;Manhattan Project. Einstein was in support of defending the Allied forces, but largely denounced using the new discovery of&nbsp;nuclear fission&nbsp;as a weapon. Later, with the British philosopher&nbsp;Bertrand Russell, Einstein signed the&nbsp;Russell&ndash;Einstein Manifesto, which highlighted the danger of nuclear weapons. Einstein was affiliated with the&nbsp;Institute for Advanced Study&nbsp;in&nbsp;Princeton, New Jersey, until his death in 1955.</p>
<p>Einstein published&nbsp;more than 300 scientific papers&nbsp;along with over 150 non-scientific works.[6][8]&nbsp;His great intellectual achievements and originality have made the word &quot;Einstein&quot; synonymous with&nbsp;genius.[9]</p>
</div>
</div>', NULL, N'', NULL, N'<menu status="" sortorder="" /><tags>education</tags><tags>family</tags><tags>emigration</tags><tags>relativity</tags>', NULL, NULL, 0, N'Public', 1, NULL, N'No one', 0, NULL, 0, NULL, N'<message by="James Mohler" date="2013-04-10T21:05:07.987" title="XML Conf updated" ip="142.136.11.230" />', N'<message by="Admin " date="2013-04-06T22:22:19.993" title="Created" ip="142.136.11.230" />')
GO





INSERT [dbo].[Pref] ([Pref], [xmlPref], [DeleteDate], [Modified], [Created]) VALUES (N'Components', N'<data type="about_us">&lt;h2&gt;About Us&lt;/h2&gt;

&lt;p&gt;I am just a website, but my creator is a talented developer who works in&lt;/p&gt;

&lt;ul&gt;
	&lt;li&gt;Microsoft SQL&lt;/li&gt;
	&lt;li&gt;Twitter Bootstrap&lt;/li&gt;
	&lt;li&gt;jQuery&lt;/li&gt;
	&lt;li&gt;GitHub&lt;/li&gt;
	&lt;li&gt;Apple MacOS&lt;/li&gt;
	&lt;li&gt;Adobe ColdFusion&lt;/li&gt;
&lt;ul&gt; 


</data><data type="sidebar">&lt;h2&gt;PlumaCMS Features&lt;/h2&gt;
&lt;ul&gt; 
	&lt;li&gt;XML based data storage&lt;/li&gt; 
	&lt;li&gt;Easy to learn User Interface&lt;/li&gt; 
	&lt;li&gt;''Undo'' protection &amp;amp; backups&lt;/li&gt; 
	&lt;li&gt;Easy to theme&lt;/li&gt; 
	&lt;li&gt;Web Service Enabled&lt;/li&gt; 
	&lt;li&gt;One on one support&lt;/li&gt; 
&lt;/ul&gt;
</data><data type="featured">&lt;h2&gt;Featured Sites&lt;/h2&gt;
&lt;ul&gt;
	&lt;li&gt;&lt;a href="http://www.webworldinc.com"&gt;Web World Inc.&lt;/a&gt;&lt;/li&gt; 
	&lt;li&gt;&lt;a href="http://www.thyroidologists.com"&gt;Thyroidologists&lt;/a&gt;&lt;/li&gt; 
&lt;/ul&gt;

</data>', NULL, N'<message by="James Mohler" date="2013-04-11T19:10:20.220" title="Preferences Saved" ip="142.136.11.230" />', N'<message by="" date="2013-04-03T21:52:58.007" title="Created" ip="142.136.11.230" />')
GO

INSERT [dbo].[Pref] ([Pref], [xmlPref], [DeleteDate], [Modified], [Created]) VALUES (N'Innovation', N'<data type="facebook">https://www.facebook.com/james.mohler.182</data><data type="stackoverflow">http://stackoverflow.com/users/1845869/james-mohler</data><data type="search">1</data><data type="linkedin" /><data type="tags">1</data><data type="twitter">https://twitter.com/JamesAMohler</data><data type="login">1</data>', NULL, N'<message by="James Mohler" date="2013-04-11T18:51:48.780" title="Preferences Saved" ip="142.136.11.230" />', N'<message by="James Mohler" date="2013-04-07T23:43:00.637" title="Created" ip="142.136.11.230" />')
GO

INSERT [dbo].[Pref] ([Pref], [xmlPref], [DeleteDate], [Modified], [Created]) VALUES (N'Meta', N'<data type="title">PlumaCMS</data><data type="root">http://foundation.qcliving.com/</data><data type="email">james@webworldinc.com</data>', NULL, N'<message by="" date="2013-04-03T21:52:57.900" title="Preferences Saved" ip="142.136.11.230" />', N'<message by="" date="2013-04-03T21:52:57.900" title="Created" ip="142.136.11.230" />')
GO

INSERT [dbo].[Pref] ([Pref], [xmlPref], [DeleteDate], [Modified], [Created]) VALUES (N'Plugin', N'<data type="bootswatch">1</data><data type="traffic">1</data><data type="event">1</data>', NULL, N'<message by="James Mohler" date="2013-04-07T22:24:10.833" title="Preferences Saved" ip="142.136.11.230" />', N'<message by="James Mohler" date="2013-04-07T21:31:49.423" title="Created" ip="142.136.11.230" />')
GO

INSERT [dbo].[Pref] ([Pref], [xmlPref], [DeleteDate], [Modified], [Created]) VALUES (N'Theme', N'<data type="current">Innovation</data>', NULL, N'<message by="" date="2013-04-03T21:52:57.930" title="Preferences Saved" ip="142.136.11.230" />', N'<message by="" date="2013-04-03T21:52:57.930" title="Created" ip="142.136.11.230" />')
GO

