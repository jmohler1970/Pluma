DELETE
FROM	 	dbo.NodeArchive
GO

DELETE
FROM	dbo.Node
GO

DELETE
FROM	dbo.Users
GO


SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [login], [passhash], [PersonName], [TempPersonName], [homepath], [loginTarget], [PHP], [lastLogin], [uStatus], [ExpirationDate], [Stars], [xmlAbout], [xmlProfile], [xmlContact], [xmlLink], [xmlPref], [email], [keyphoto], [personalStatus], [commentMode], [comments], [xmlGroup], [PrefGroup], [Active], [DeleteDate], [ModifyDate], [ModifyBy], [CreateDate], [CreateBy]) VALUES (1019, N'james', N'7C34306644', N'<PersonName xmlns="http://ns.hr-xml.org/2007-04-15"><GivenName>James</GivenName><FamilyName>Mohler</FamilyName></PersonName>', N'<PersonName xmlns="http://ns.hr-xml.org/2007-04-15"><GivenName>James</GivenName><FamilyName>Mohler</FamilyName></PersonName>', N'James', N'community.home', N'Public', CAST(0xA13E041E AS SmallDateTime), N'Confirmed', NULL, 0, N'<profile type="gender">male</profile><profile type="occupation">Computer Programmer</profile><profile type="location">In the closet</profile><profile type="country">US and A</profile><profile type="college">Cal State Fullerton</profile><profile type="INTEREST">I like cats.</profile><profile type="TODO">See Niagra Falls</profile><contact type="address">Orangethorpe</contact><contact type="city">Fullerton</contact><contact type="stateprovince">CA</contact><contact type="postalcode">92833</contact><follow href="www.youtube.com/jamesparson">YouTube</follow>', N'<profile type="COLLEGE">CSUF</profile><profile type="OCCUPATION">Geek</profile><profile type="COUNTRY">US and A</profile><profile type="TODO">Visit Australia</profile><profile type="GENDER">male</profile><profile type="LOCATION">In the closet</profile>', N'<contact type="organization">Web World Inc</contact><contact type="city">Fullerton</contact><contact type="stateprovince">CA</contact><contact type="postalcode">92833</contact>', N'<follow href="http://www.seethis.com">YouTube</follow>', N'', N'james@webworldinc.com', N'1z5hwr9.jpg', N'The cat is resting', NULL, N'', N'<group type="System">System</group>', N'Contributor', 1, NULL, CAST(0xA07504A8 AS SmallDateTime), N'James Mohler', CAST(0x9F2A030C AS SmallDateTime), N'Welcome Guest')

INSERT [dbo].[Users] ([UserID], [login], [passhash], [PersonName], [TempPersonName], [homepath], [loginTarget], [PHP], [lastLogin], [uStatus], [ExpirationDate], [Stars], [xmlAbout], [xmlProfile], [xmlContact], [xmlLink], [xmlPref], [email], [keyphoto], [personalStatus], [commentMode], [comments], [xmlGroup], [PrefGroup], [Active], [DeleteDate], [ModifyDate], [ModifyBy], [CreateDate], [CreateBy]) VALUES (1020, N'ben', NULL, N'<PersonName xmlns="http://ns.hr-xml.org/2007-04-15"><GivenName>Ben</GivenName><FamilyName>Conner</FamilyName></PersonName>', N'<PersonName xmlns="http://ns.hr-xml.org/2007-04-15"><GivenName>Ben</GivenName><FamilyName>Conner</FamilyName></PersonName>', N'Ben', N'user.home', N'Public', CAST(0xA0C40485 AS SmallDateTime), N'Confirmed', NULL, 0, NULL, NULL, NULL, NULL, NULL, N'ben@webworldinc.com', NULL, NULL, N'Closed', N'', N'<group type="System">System</group>', N'Contributor', 1, NULL, CAST(0x9F9E0565 AS SmallDateTime), N'James Mohler', CAST(0x9F2A03D9 AS SmallDateTime), N'James Mohler')

SET IDENTITY_INSERT [dbo].[Users] OFF 

SET IDENTITY_INSERT [dbo].[Node] ON 

INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [ModifyBy], [ModifyDate], [CreateBy], [CreateDate]) VALUES (378, NULL, 0, 1, N'', N'<title>Web World Inc</title>', N'Category', NULL, N'', N'', N'', N'', N'<security role="Public" read="1" /><security role="Other" read="1" /><security role="Group" id="Advertiser" read="1" write="1" /><security role="Owner" id="1019" read="1" write="1" />', NULL, 0, N'Approved', 1, NULL, N'Closed', 0, NULL, 0, NULL, N'James Mohler', CAST(0x9FE1050C AS SmallDateTime), N'James Mohler', CAST(0x9FD5052D AS SmallDateTime))


INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [ModifyBy], [ModifyDate], [CreateBy], [CreateDate]) VALUES (379, 378, 1, 0, N'home', N'<title>Web World Inc</title><subtitle />', N'Page', N'<p>The Internet does not stop, nor do we. Our Hosting and Development teams work tirelessly to provide the best Internet solutions. We want to make your business website the best it can be.</p>
<p>&nbsp;</p>
<p><a href="/index.cfm/main/hosting" class="btn btn-primary btn-large">Learn more &raquo;</a></p>
<p>&nbsp;</p>
<hr />
<!-- Example row of columns -->
<div class="row">
<div class="span4">
<h2>Web Hosting</h2>
<ul>
    <li>Gigabytes of web space</li>
    <li>Wide bandwidth</li>
    <li>Gigabytes of data transfer</li>
</ul>
<p>Don''t be limited by what so-called &quot;Free&quot; websites offers you. We build powerful websites to meet your needs for today and tomorrow.</p>
<p><a class="btn" href="/index.cfm/main/hosting">View details &raquo;</a></p>
</div>
<div class="span4">
<h2>Site Development</h2>
<ul>
    <li>Microsoft SQL Server 2005, 2008, 2012</li>
    <li>Adobe ColdFusion 9</li>
    <li>HTML 5</li>
    <li>Desktop and mobile devices</li>
    <li>RSS feeds</li>
    <li>SAS</li>
</ul>
<p>On site consultation in Los Angeles and Orange County</p>
</div>
<div class="span4">
<h2>Support Team</h2>
<ul>
    <li>Rapid customer support via Phone or Email</li>
    <li>We keep your site running</li>
    <li>When something happens, we are here to help you now.</li>
    <li>Highly trained, tested, and mentored staff</li>
</ul>
<p>Let us be your Internet Tech Support Team.</p>
<p>&nbsp;</p>
</div>
</div>
<p>&nbsp;</p>', N'', N'<theme_template>home_splash.cfm</theme_template><href>http://</href>', N'', N'<menu status="" sortorder="3">Home</menu>', N'<security role="Public" read="1" /><security role="Other" read="1" /><security role="Group" id="Advertiser" read="1" /><security role="Owner" id="1019" read="1" write="1" />', NULL, 0, N'Public', 1, NULL, N'No one', 0, 9, 1, NULL, N'James Mohler', CAST(0xA13A04EF AS SmallDateTime), N'James Mohler', CAST(0x9FD5052D AS SmallDateTime))


INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [ModifyBy], [ModifyDate], [CreateBy], [CreateDate]) VALUES (380, 378, 0, 0, N'whats-new', N'<title>What''s New</title>', N'Page', N'<p>This page displays an up-to-date listing of changes to our customer      support web. We''ll also place notices here regarding product updates,      scheduled releases, or problems and work-arounds that may affect all      customers.</p>
<p><strong>Jan 10, 2012</strong>: Our main web server lost it''s hard drive this morning about 10:30. We are restoring to a new drive from last night''s backup. This process will take several hours. Email and a few websites were not affected. We expect this to be done around 8 to 9 pm tonight.</p>
<p><strong>Jul 16, 2011</strong>: The last few days we''ve been getting reports of problems connecting to the mail server through a web browser. After some testing, it definitely is not the mail server itself, but appeared to be our router. Tried swapping out a network card in the router yesterday but that didn''t help, so we swapped out the entire router this morning. We will continue to monitor the issue and see if the changes we made have any effect.</p>
<p><strong>Mar 9, 2011</strong>: We''re getting reports of missing email and/or folders from some clients. We are working with the tech support staff for the mail server to resolve this issue.</p>
<p><strong>Mar 8, 2011:</strong> Mail will be down for a little while this evening starting around 9:30 while we upgrade to a new release of the mail server software. Not sure exactly how long but will let you know.</p>
<p><strong>Jan 16, 2011</strong>: The 888# issues have now been resolved.</p>
<p><strong>Jan 15, 2011</strong>: We''re having issues with our 888 # and are trying to track down why it''s being reported as out of service. In the interim, you can reach us at <strong>480-704-2000</strong>. Thank you for your patience.</p>', N'', N'<tags>customer support</tags><tags>email</tags><tags>scheduled releases</tags>', N'', N'<tags>customer support</tags><tags>email</tags><tags>scheduled releases</tags>', N'<security role="Public" read="1" /><security role="Other" read="1" /><security role="Group" id="Advertiser" read="1" /><security role="Owner" id="1019" read="1" write="1" />', NULL, 0, N'Approved', 1, NULL, N'Closed', 0, 11, 0, CAST(0xA11104EA AS SmallDateTime), N'James Mohler', CAST(0x9FD50562 AS SmallDateTime), N'James Mohler', CAST(0x9FD50532 AS SmallDateTime))
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [ModifyBy], [ModifyDate], [CreateBy], [CreateDate]) VALUES (381, 378, 0, 0, N'virus-information', N'<title>Virus Information</title>', N'Page', N'<blockquote>
<h2><a name="top">Virus Information</a></h2>
<p>This page contains text that was provided courtesy of Symantec.&nbsp; They are the     manufacturers of Norton Anti-Virus.&nbsp; This text will likely be able to answer most of     your questions regarding what a computer virus is, how it works, and how to protect     yourself.&nbsp; It also contains several links which will be able to provide you more     information.</p>
<p>To contact customer support at Symantec and Norton Anti-Virus and the other Norton Products     point your browser to     <a href="http://www.symantec.com">http://www.symantec.com</a>.&nbsp; We do <i>not</i>     provide support for Norton products.</p>
<p>They also have a special website just for the Anti-Virus portion.&nbsp; That division     is called the Symantec Anti-Virus Research Center.&nbsp; You can find them at:<br />
<a href="http://www.sarc.com">http://www.sarc.com</a></p>
<hr />
<p>Understanding Viruses and Virus Types, Including     Trojans, Hoaxes, Worms, Macros, and Boot Viruses (1999041209131106)</p>
<p>Norton Antivirus Knowledge Base</p>
<p>Technical Note</p>
<p>Understanding Viruses and Virus Types, Including Trojans, Hoaxes, Worms, Macros, and     Boot Viruses</p>
<p><font face="Courier New" size="3"><strong>Situation:</strong></font></p>
<font face="Courier New" size="3">     <blockquote>
<p><font face="Courier New" size="2">You want to know the difference between the various       types of viruses and malicious programs, and you want to know how to protect your computer       from them.</font></p>
<font face="Courier New" size="2">       </font>     </blockquote>     </font>
<p><strong><font face="Courier New" size="3">Solution:</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>This document discusses the following topics:* Definition of a Virus* Types of Viruses*       How Viruses Spread* Virus Damage* How to Practice Safe Computing* Boot Sector Viruses -       What They Are, What Are the Risks, How to Avoid Them* Email Attachments* Hoax Viruses*       Trojan Horse Viruses* Worm Viruses* File Downloads* Additional Safe Computing Habits*       Prevent and Prepare for Data Loss* How to submit a possible virus</p>
</blockquote>     </font>
<p><strong><font face="Courier New" size="3">Definition of a Virus</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>A computer virus is a small program written to alter the way a computer operates,       without the permission or knowledge of the user. A virus need meet only two criteria.       First, it must execute itself, often placing some version of its own code in the path of       execution of another program. Second, it must replicate itself. For example, it may copy       itself to other executable files or to disks that the user accesses. Viruses can invade       desktop machines and network servers alike.</p>
</blockquote>     </font>
<p><font face="Courier New" size="3"><strong>Types of Viruses</strong></font></p>
<font face="Courier New" size="2">     <blockquote>
<p>PC viruses fall into three major categories: program (or parasitic) viruses, boot       sector viruses, and macro viruses.</p>
<p>* Program viruses infect program files. These files typically have extensions such as       .COM, .EXE, .OVL, .DLL, .DRV, .SYS, .BIN, and even .BAT. Examples of known program viruses       include Jerusalem and Cascade.</p>
<p>* Boot sector viruses infect the system area of a disk -- that is, the boot record on       floppy diskettes and hard disks. All floppy diskettes and hard disks (including disks       containing only data) contain a small program in the boot record that is run when the       computer starts up. Boot sector viruses attach themselves to this part of the disk and       activate when the user attempts to start up from the infected disk. Examples of boot       sector viruses are Form, Disk Killer, Michelangelo, and Stoned. (Another class of viruses,       known as multipartite viruses, infects both boot records and program files.)</p>
<p>* Macro viruses infect Microsoft Office Word, Excel, PowerPoint and Access files. Newer       strains, however, are now turning up in other programs as well. All of these viruses use       another program''s internal programming language, which was created to allow users to       automate certain tasks within that program. Because of the ease with which these viruses       can be created, there are literally thousands of them in the wild now.</p>
</blockquote>     </font>
<p><strong><font face="Courier New" size="3">How Viruses Spread</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>The most common way a boot virus spreads is by starting a computer with an infected       floppy diskette in drive A:. Often this happens accidentally by leaving a data disk in       drive A: when starting the computer. The infected floppy diskette immediately writes its       code to the master boot record (MBR). The MBR runs each time a computer is started, so       from then on, the virus runs each time the computer is started.</p>
<p>File infectors generally spread by a user inadvertently running an infected program.       The virus loads into memory along with the program. It then infects every program run by       either that original program, or by anyone on that computer. This happens until the next       time the machine is powered down.</p>
</blockquote>     </font>
<p><strong><font face="Courier New" size="3">Virus Damage</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>Most viruses have a &quot;payload,&quot; or &quot;trigger,&quot; the action or       destruction the virus performs. Some viruses are programmed to damage the computer by       corrupting programs, deleting files, or reformatting the hard disk. Others are not       designed to do any damage, but simply to replicate themselves and make their presence       known by presenting text, video, and audio messages. Even these benign viruses, however,       can create problems for the computer user. They typically take up computer memory used by       legitimate programs. As a result, they often cause erratic behavior and can result in       system crashes. In addition, many viruses are bug-ridden, and the bugs may lead to system       crashes and data loss.</p>
</blockquote>     </font>
<p><strong><font face="Courier New" size="3">How to Practice Safe Computing</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>With all the hype, it is easy to believe that viruses lurk in every file, every email,       every web site. However, a few basic precautions can minimize your risk of infection.       Practice safe computing and encourage everyone you know to do so as well.</p>
<p>Make sure your virus definitions are up-to-date. Use LiveUpdate (or your preferred       method) to download the latest virus definitions at least once a week. For more       information on updating virus definitions, please see the document SARC SUPPORT:       Downloading and Using Virus Definitions.</p>
<p>Keep Norton AntiVirus (NAV) Auto-Protect running with the correct options on your       computer at all times. &quot;Correct options&quot; are set automatically when NAV is       installed and include the following:* Make sure that you have set NAV to scan floppy disks       on access and at shutdown. For more information, see the document Checking Floppies for       Boot Viruses Upon Access. Set NAV Auto-Protect to launch at startup and to scan files when       any of these file or program operations occur:* Run* Open* Copy* Move* Create* Download.       These precautions will keep you protected against almost all virus threats!</p>
</blockquote>     </font><font face="Courier New" size="4"><hr />
</font>
<p><strong><font face="Courier New" size="3">What Are Boot Sector Viruses</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>Boot sector viruses are viruses that infect the &quot;boot sector&quot; of a hard drive       or a floppy disk. What is a boot sector? When a computer starts up, one of the first       things it has to do is examine a special part of your hard drive (or floppy disk if one is       in the floppy drive) for information, or code, about how to boot up. This is the boot       sector. As the machine starts and it reads that special code, it also &quot;loads&quot;       some of that code into RAM (memory).</p>
<p>If a boot sector virus has infected the drive''s boot sector, then that bit of code has       been overwritten by the virus or it coexists with the virus. As the infected computer       boots up, it loads not the normal, &quot;clean&quot; code, but viral code. Once the virus       is loaded into memory, every single time you try to access a floppy disk in your floppy       drive, that virus in memory checks to see if it exists on that floppy. If it exists on the       floppy, nothing happens. But if the floppy disk is not yet infected, the virus writes a       copy of itself to that floppy''s boot sectors. If anyone leaves that floppy disk in their       floppy drive the next time they boot up, the virus will load into memory and start the       process again.</p>
<p>What happens if you boot from an infected floppy disk, but your machine is not       infected? If you boot a computer using an infected floppy but the machine itself is clean,       once that virus loads into memory, it will check the local hard drive''s boot sectors to       see if a copy of itself exists. If not, it will copy itself to the boot sector of the hard       drive, and now that machine is infected.</p>
</blockquote>     </font>
<p><font face="Courier New" size="3"><strong>What Are the Risks of Boot Sector     Viruses</strong></font></p>
<font face="Courier New" size="3">     <blockquote>
<p><font face="Courier New" size="2">Though boot sector viruses are not receiving as much       attention as macro viruses, they are still alive and well &quot;in the wild.&quot; Just as       you should treat every gun as if it were loaded, treat every floppy as if it were       infected. Since boot sector viruses spread via floppy disks and bootable CDs, every floppy       disk and CD should be scanned for viruses. Shrink-wrapped software, demo disks from       suppliers, and &quot;trial&quot; software are NOT exempt from this rule. Viruses have been       found even on retail software.</font></p>
<font face="Courier New" size="2">
<p>Additionally, beware of the disk that has been to someone''s home office or school       computer lab. It is always possible that their antivirus protection had been turned off,       and the floppy may have become infected. If the floppy is not scanned, it could infect the       workplace, too. Update your virus definitions at least weekly and set NAV to scan all       floppies upon access and on shut down.</p>
</font>     </blockquote>     </font>
<p><strong><font face="Courier New" size="3">How to Avoid Boot Sector Viruses</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>Avoid leaving a floppy disk in the computer when you shut it down. On restart, the       computer will attempt to read from the floppy drive and this is when the boot sector virus       could infect the hard drive.</p>
<p>Always write-protect your floppy disks after you have finished writing to them.</p>
</blockquote>     <hr />
</font>
<p><strong><font face="Courier New" size="3">Email Attachments</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>Simply reading or opening an email message cannot spread a virus. However, if your       email system is set in any way to &quot;auto-run&quot; attachments, you are definitely at       risk.</p>
<p>Email attachments are a major source of virus infections. Microsoft Office attachments       for Word, Excel, and Access can be infected by Macro viruses. Other attachments can       contain &quot;file infector&quot; viruses. Norton AntiVirus Auto-Protect will scan these       attachments for viruses as you open or detach them. Keep NAV Auto-Protect running       constantly on your computer to avoid infecting yourself or others via email attachments.</p>
</blockquote>     <hr />
</font>
<p><strong><font face="Courier New" size="3">Additional Safe Computing Habits</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>Be suspicious of email attachments from unknown sources. Opening or running those       attachments can be like &quot;taking candy from strangers.&quot;.</p>
<p>Newer viruses can send email messages that appear to be from people you know. Some       warning signs:* Do you usually receive email from this person?* If yes, does the person       usually use phrases like &quot;Read me NOW!! URGENT!!!&quot;?* Does your email system       format the subject lines to read &quot;Important message from
<person_you_know>&quot;?* If the body of the email says &quot;Here is the document       you requested&quot; or &quot;here''s the information you wanted,&quot; did you, in fact,       ask for it?</person_you_know>
</p>
</blockquote>     <hr />
</font>
<p><strong><font face="Courier New" size="3">Hoax Viruses</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>Hoax viruses are messages about viruses that are supposed to spread simply by reading       email. These messages are extremely common. In fact, they amount to little more than chain       letters. Common indicators of a hoax virus are listed below. If you receive an email with       all or most of the following phrases, it''s very likely a hoax:* If you receive an email       titled [email virus hoax name here], do not open it!* Delete it immediately!!! * It       contains the [hoax name] virus.* It will delete everything on your hard drive and [extreme       and improbable danger specified here].* This virus was announced today by [reputable       organization name here].* Forward this warning to everyone you know!!!</p>
<p>Most hoax virus warnings do not deviate far from this pattern. If you are unsure if a       virus warning is legitimate or a hoax, search the Symantec AntiVirus Research Center       (SARC) web site at http://www.symantec.com/avcenter/hoax.html. If the email contains a       file you are supposed to run, it is probably a Trojan Horse (see next section), and you       should consider submitting to Symantec Antivirus Research Center (SARC). Please refer to       http://service1.symantec.com/SUPPORT/nav.nsf/docid/1999052109284606 How to Submit a       Possible Virus Sample to the Symantec AntiVirus Research Center for assistance on       submitting a virus sample.</p>
</blockquote>     <hr />
</font>
<p><strong><font face="Courier New" size="3">Trojan Horse Viruses</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>Trojan Horses are impostors -- files that claim to be something desirable but, in fact,       are malicious. A very important distinction from true viruses is that they DO NOT       replicate themselves, as viruses do. They are not really viruses, but are often referred       to as viruses.</p>
<p>Reputable, public sites are extremely unlikely to contain Trojan Horse files. However,       unsolicited email attachments or downloadable files could certainly be Trojan Horses. Many       Word macro viruses are also considered Trojan Horses. For a full listing of Trojan Horses,       go to the SARC website at http://www.symantec.com/avcenter/vinfodb.html and search for       &quot;trojan.&quot;</p>
</blockquote>     <hr />
</font>
<p><font face="Courier New" size="3"><strong>Worm Viruses</strong></font></p>
<font face="Courier New" size="3">     <blockquote>
<p><font face="Courier New" size="2">Worm viruses are programs that replicate themselves       from system to system without a use of a host file. This is in contrast to viruses, which       require a host file to infect and then spread from there. Many macro viruses are       considered worms.</font></p>
<font face="Courier New" size="2">
<p>Although worm viruses generally &quot;live&quot; inside of other files, usually Word or       Excel type documents, there is a difference between how worms and viruses use the host       file. Usually the worm creator will release a document that already has the       &quot;worm&quot; macro inside the document. This document will not -- and should not --       change because of the worm''s code or specification. The entire document will travel from       computer to computer, so the entire document should be considered the worm.</p>
<p>A good way to look at this is to imagine that you have a binary worm (EXE or       executable). It has an EXE header and the body of the code. Thus, the worm is EXE       &quot;header&quot; + &quot;code&quot; and not just the EXE &quot;code&quot;. To extend       this to a worm, a worm document would be like the header of the executable. Without the       document, the worm would not work and would not be a worm.</p>
</font>     </blockquote>     </font><font face="Courier New" size="2"><hr />
</font>
<p><strong><font face="Courier New" size="3">File Downloads</font></strong></p>
<font face="Courier New" size="2">     <blockquote>
<p>Bulletin Board Systems (BBS) and the Internet are a source of nearly unlimited       information, files and programs. Unfortunately, any publicly posted file could potentially       be infected with a virus. Minimize the risk of infection by scanning files with NAV as you       download them. This is a default feature of NAV''s Auto-Protect. In addition, make sure       that Auto-Protect is constantly running on your computer and that your virus definitions       are up-to-date.</p>
</blockquote>     <hr />
</font>
<p><font face="Courier New" size="3"><strong>Additional Safe Computing Habits</strong></font></p>
<font face="Courier New" size="3">     <blockquote>
<p><font face="Courier New" size="2">Use common sense. If a file or program seems too good       to be true, it probably is.</font></p>
<font face="Courier New" size="2">
<p>Many of the most virulent viruses (including Melissa) were originally downloaded from       pornographic newsgroups, web sites, and user groups.</p>
</font>     </blockquote>     </font><font face="Courier New" size="2"><hr />
</font>
<p><font face="Courier New" size="3"><strong>Prevent and Prepare for Data Loss</strong></font></p>
<font face="Courier New" size="3">     <blockquote>
<p><font face="Courier New" size="2">Backing up your files is a lot like flossing your       teeth. It can be time consuming. It can seem pointless. But as your dentist says,       &quot;Don''t floss all your teeth -- just the ones you want to keep.&quot; It takes only       one major loss of data to make you wish you had been backing up your files all along.       Therefore, back up your important data files on a regular basis. Keep the media -- whether       floppy, Zip, Jaz, or tape -- in a protected place and write protect them.</font></p>
<font face="Courier New" size="2">       </font>     </blockquote>     </font><font face="Courier New" size="2"><hr />
</font>
<p><font face="Courier New" size="3"><strong>How to Submit a Possible Virus</strong></font></p>
<font face="Courier New" size="3">     </font><blockquote>
<p><font size="2">Please refer to       http://service1.symantec.com/SUPPORT/nav.nsf/docid/1999052109284606 How to Submit a       Possible Virus Sample to the Symantec AntiVirus Research Center for assistance on </font></p>
</blockquote>     <hr />
<table border="0">
    <tbody>
        <tr>
            <td>&nbsp;</td>
        </tr>
    </tbody>
</table>
<p>&nbsp;</p>
</blockquote>', N'', N'<tags>virus</tags><tags>symantec</tags><tags>safe computing</tags>', N'', N'<tags>virus</tags><tags>symantec</tags><tags>safe computing</tags>', N'<security role="Public" read="1" /><security role="Other" read="1" /><security role="Group" id="Advertiser" read="1" /><security role="Owner" id="1019" read="1" write="1" />', NULL, 0, N'Approved', 1, NULL, N'Closed', 0, 8, 0, CAST(0xA11104EA AS SmallDateTime), N'James Mohler', CAST(0x9FD5055F AS SmallDateTime), N'James Mohler', CAST(0x9FD50533 AS SmallDateTime))
INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [ModifyBy], [ModifyDate], [CreateBy], [CreateDate]) VALUES (382, 378, 0, 0, N'faq', N'<title>FAQ</title>', N'Page', N'<blockquote>
    <blockquote>
        <h2><a name="top">FAQ -- Frequently Asked Questions</a></h2>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <p>This page contains answers to common questions handled
        by our support staff, along with some tips and tricks
        that we have found useful and presented here as
        questions.</p>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <p><strong>Note</strong>: In these answers we will follow
        a few shorthand conventions for describing user-interface
        procedures. Key combinations will be presented like this:
        <tt>Ctrl+Alt+Delete</tt>, which means that you should
        press and hold down the Control key, the Alt key, and the
        Delete key at the same time. Menu selections will be
        presented like this: <tt>File-&gt;Open</tt>, which means
        that you should open the File menu, and then make the
        Open selection.</p>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <ol>
            <li><a href="faq.htm#q1">How do I … ?</a></li>
            <li><a href="faq.htm#q2">Where can I find … ?</a></li>
            <li><a href="faq.htm#q3">Why doesn''t … ?</a></li>
            <li><a href="faq.htm#q4">Who is … ?</a></li>
            <li><a href="faq.htm#q5">What is (are)… ?</a></li>
            <li><a href="faq.htm#Tips">Maintenance tips …</a></li>
        </ol>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <hr>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <h3><a name="q1">How do I … ?</a></h3>
        <p>Q. Set up Email?</p>
        <p>A. <a href="faqOutlook.htm">Click here</a> for Outlook
        97, <a href="email.html">Click here for others</a></p>
        <p>Q. Download a program?</p>
        <p>A. Our download page offers links to many important
        files for Internet Users. In most cases. these links,
        take you to the software manufacturer''s download page. </p>
        <ol>
            <li>These page have a link which will download the
                file.</li>
            <li>You will be prompted as to the location for it to
                be downloaded into. We recommend that you place
                the file in either (a) a floppy disk; if it will
                fit, (b) a subfolder off of the desktop, or ©
                into your C:\WINDOWS\TEMP folder. We <em><strong><u>do
                not</u></strong></em> recommend you place it into
                (a) the root of your hard drive, (b) the
                C:\WINDOWS folder, © the folder that you will
                eventually install the software or (d) in a
                folder that already has another downloaded
                program.</li>
            <li>Once you have chosen a good location, click Save.</li>
        </ol>
        <p>If you have any difficulty with downloading, give us a
        call and we will gladly assist you.</p>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <p>Q. I extract files?</p>
        <p>A. Files to be extracted come in two forms. </p>
        <ul>
            <li>If the file has an &quot;.exe&quot; extension, do
                as follows:</li>
        </ul>
        <blockquote>
            <ol>
                <li>Make sure that the &quot;.exe&quot; has been
                    copied into an empty folder.</li>
                <li>Double click. You may have to specify the
                    path. Normally this should be the current
                    folder</li>
                <li>The files will then be extracted.</li>
            </ol>
        </blockquote>
        <ul>
            <li>If the file has an &quot;.zip&quot; extension, do
                as follows:</li>
        </ul>
        <blockquote>
            <ol>
                <li>Make sure you have a program that supports
                    extracting zipped files. Programs such as
                    WinZip, PowerDesk, Norton Navigator, Zip-it,
                    or a current version of pkunzip.</li>
                <li>Follow that programs instructions for
                    unzipping to an empty folder.</li>
            </ol>
        </blockquote>
        <blockquote>
            <p>Once the files have been extracted, the original
            archive can be deleted or saved for future use.</p>
        </blockquote>
    </blockquote>
    <blockquote>
        <h5><a href="faq.htm#top">Back to Top</a></h5>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <hr>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <h3><a name="q2">Where can I find … ?</a></h3>
        <p>Q. Glossary of important computer terms?</p>
        <p>A. <a href="glossary.htm">Right here</a></p>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <p>Q. The latest version of Netscape?</p>
        <p>A. <a href="http://www.netscape.com/download/index.html">Click
        here</a></p>
        <p>Q The latest version of Internet Explorer?</p>
        <p>A. <a href="http://www.microsoft.com/ie/main.asp">Click
        here</a></p>
        <p>Q. The latest version of Eudora?</p>
        <p>A. <a href="http://www.eudora.com/eudoralight/#download">Click
        here</a></p>
        <p>This is the answer to the question. This is the answer
        to the question. This is the answer to the question. This
        is the answer to the question. This is the answer to the
        question. This is the answer to the question. This is the
        answer to the question. This is the answer to the
        question. </p>
    </blockquote>
    <blockquote>
        <h5><a href="faq.htm#top">Back to Top</a></h5>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <hr>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <h3><a name="q3">Why doesn''t … ?</a></h3>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <p><a name="tipoftheday">Q.</a> Why do I not always get a
        &quot;Connect to&quot; window when I start up my web
        browser or email program?</p>
        <p>A. The browser needs to have the &quot;Connect to the
        Internet as needed&quot; feature enabled. To do this:
        click on Start -&gt;Settings-&gt;Control Panel. Double
        click on the Internet. Click on the tab marked
        &quot;Connection&quot; and put a check in &quot;Connect
        to the Internet as need&quot;. </p>
        <p>Just below the check box, the list box may display Web
        World Inc. If so click OK. The feature has been enabled.
        If not, click on the down arrow, then click on Web World
        Inc. Then click OK.</p>
        <p><strong>Q. </strong>Why is my web browser somtimes
        unable to get to a web site?</p>
        <p><strong>A. </strong>Sometimes this error message will
        occur after you have been on the Internet for a while and
        the modem disconnects. This can happen because (a) the
        Internet is busy and the site could not be contacted (b)
        you have not clicked on anything recently and you were
        automatically disconnected. © Static in the phone lines
        caused your modem to reset.</p>
        <ul>
            <li>If (a) try going to the site at a latter time.</li>
            <li>If (b) we do this because many times, when you
                are done surfing the Internet, the dial up
                connection may not close out</li>
            <li>If © your computer may not be able to reliably
                stay connect at the speed it connected it at.
                Call us to see if this is the problem.</li>
        </ul>
        <p>Q. My connection go through the first time?</p>
        <p>A. This can have several possible causes:</p>
        <ul>
            <li>The modem may not have dialed, most modems make
                noises as they are connecting.</li>
            <li>The number you called may be one of the old
                numbers which is no longer in use. Click here to
                see the new numbers for your area.</li>
            <li>If it asks for your password more than once, you
                may have misspelled your user name, or password.
                Your <strong>Caps Lock</strong> key may be on.</li>
            <li>One of our modems may be malfunctioning. Please
                call us so that we can reset the modems and you
                can get on.</li>
        </ul>
    </blockquote>
    <blockquote>
        <h5><a href="faq.htm#top">Back to Top</a></h5>
    </blockquote>
</blockquote>

<blockquote>
    <hr>
</blockquote>

<blockquote>
    <blockquote>
        <h3><a name="q4">Who is … ?</a></h3>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <p>Q. The person who built this website?</p>
        <p>A. Click here</p>
    </blockquote>
    <blockquote>
        <h5><a href="faq.htm#top">Back to Top</a></h5>
    </blockquote>
</blockquote>

<blockquote>
    <hr>
</blockquote>

<blockquote>
    <blockquote>
        <h3><a name="whatis">What is … ?</a></h3>
        <p>Q. Web World Inc.''s dial up phone numbers and how do I
        change them?</p>
        <p>A. <a href="dialups.htm">Click here</a></p>
        <p>Q. Windows 95 Service Pack 1?</p>
        <p>A. It is a collection of enhancements and bug fixes to
        the original Windows 95 release. Only users of the
        original release of Windows 95 need to install Service
        Pack 1. To find out if your computer needs it, do the
        following:</p>
        <ol>
            <li>Right click on My Computer.</li>
            <li>Left click on Properties</li>
            <li>The System Properties dialog box appears, with
                the general tab on top.</li>
            <li>On this tab, one of the things listed is
                Microsoft Windows 95, followed by either
                4.00.950, 4.00.950a, 4.00.950b, 4.00.1381.</li>
        </ol>
        <blockquote>
            <p>If your computer says 4.00.950, install <a href="download.htm#item1">Service Pack 1</a>.<br>
            If your computer says 4.00.950a, Service Pack 1 is
            already installed.<br>
            If your computer says 4.00.950b, this computer has
            even more enhancements and bug fixes. This version is
            only available in new computers.<br>
            If your computer says 4.00.1381, this computer is
            running Windows NT, not Windows 95. Don''t even think
            about putting this into your computer.</p>
        </blockquote>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <p>Q. &quot;Netscape is unable to locate the
        server…&quot;?</p>
        <p>A. This means either (a) we cannot find the site the
        other end, or (b) you many have lost your connection, ©
        not yet connect, or (d) due to heavy traffic on the
        Internet, the site could not be found before the computer
        gave up.</p>
        <p>This is the answer to the question. This is the answer
        to the question. This is the answer to the question. This
        is the answer to the question. This is the answer to the
        question. This is the answer to the question. This is the
        answer to the question. This is the answer to the
        question. </p>
    </blockquote>
    <blockquote>
        <p>This is the answer to the question. This is the answer
        to the question. This is the answer to the question. This
        is the answer to the question. This is the answer to the
        question.</p>
        <p>Q. What is<a name="Internet Explorer 4.0"> Internet
        Explorer 4.0</a> Beta 2?</p>
        <p>A. Internet Explorer 4.0 is currently in its second
        phase of wide release testing. It is an unfinished
        product, that is not yet ready to be put on everyone''s
        computer. At Web World, it is our policy to <strong>not</strong>
        support any beta products. Users are advised not to
        install this onto their computers until a final release
        has been issued.</p>
    </blockquote>
    <blockquote>
        <h5><a href="faq.htm#top">Back to Top</a></h5>
        <hr>
    </blockquote>
</blockquote>

<blockquote>
    <blockquote>
        <h3><a name="Tips">Performance Tips</a></h3>
        <ul>
            <li>Have a current Antivirus program on your
                computer.</li>
            <li>Every 3 months, when no programs are running, you
                should delete all files in the C:\Windows\Temp
                folder.</li>
            <li>Every 6 months, you should run Scandisk, then
                Disk Defragmenter. Both can be found in
                Start-&gt;Programs-&gt;Accessories-&gt;System
                Tools.</li>
        </ul>
        <h5><a href="faq.htm#top">Back to Top</a></h5>
        <hr>
    </blockquote>
</blockquote>', N'', N'<tags>faq</tags>', N'', N'<tags>faq</tags>', N'<security role="Public" read="1" /><security role="Other" read="1" /><security role="Group" id="Advertiser" read="1" /><security role="Owner" id="1019" read="1" write="1" />', NULL, 0, N'Approved', 1, NULL, N'Closed', 0, 3, 0, CAST(0xA1110515 AS SmallDateTime), N'James Mohler', CAST(0x9FD5056E AS SmallDateTime), N'James Mohler', CAST(0x9FD50533 AS SmallDateTime))

INSERT [dbo].[Node] ([NodeID], [ParentNodeID], [root], [PrimaryRecord], [Slug], [xmlTitle], [Kind], [strData], [xmlData], [xmlConf], [xmlLink], [xmlTaxonomy], [xmlSecurity], [ExpirationDate], [pinned], [pStatus], [cStatus], [StartDate], [CommentMode], [StationaryPad], [SortOrder], [NoDelete], [DeleteDate], [ModifyBy], [ModifyDate], [CreateBy], [CreateDate]) VALUES (383, 378, 0, 0, N'downloads', N'<title>Downloads</title>', N'Page', N'', N'<table class="table table-condensed"><thead><tr><th>Services Price List</th><th>col_2</th><th>col_3</th><th>Prices valid from [Date] to [Date]</th></tr></thead><tr><td>Service ID</td><td>Service Type</td><td>Description</td><td>Price per Hour or Incident</td></tr><tr><td>01-0987</td><td>Service 1</td><td>Description 1</td><td style="text-align : right">$90.00</td></tr><tr><td>02-0987</td><td>Service 2</td><td>Description 2</td><td style="text-align : right">$125.00</td></tr><tr><td>03-0987</td><td>Service 3</td><td>Description 3</td><td style="text-align : right">$175.00</td></tr><tr><td>01-0123</td><td>Service 4</td><td>Description 4</td><td style="text-align : right">$65.00</td></tr><tr><td>02-0123</td><td>Service 5</td><td>Description 5</td><td style="text-align : right">$80.00</td></tr><tr><td>03-0123</td><td>Service 6</td><td>Description 6</td><td style="text-align : right">$125.00</td></tr><tr><td>04-0123</td><td>Service 7</td><td>Description 7</td><td style="text-align : right">$200.00</td></tr></table>', N'<autopage>Share</autopage>', N'', N'', N'<security role="Public" read="1" /><security role="Other" read="1" /><security role="Group" id="Advertiser" read="1" /><security role="Owner" id="1019" read="1" write="1" />', NULL, 0, N'Approved', 1, NULL, N'Closed', 0, 4, 0, CAST(0xA1110515 AS SmallDateTime), N'James Mohler', CAST(0xA0AE0490 AS SmallDateTime), N'James Mohler', CAST(0x9FD50534 AS SmallDateTime))


SET IDENTITY_INSERT [dbo].[Node] OFF 
