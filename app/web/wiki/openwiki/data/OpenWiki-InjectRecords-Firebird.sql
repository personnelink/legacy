-- these values were taken from the original access database */
delete from openwiki_revisions;
-------------------------------------------------------------------------------
-- openwiki_interwikis
-------------------------------------------------------------------------------
delete from openwiki_interwikis;
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'Dictionary','http://www.dictionary.com/cgi-bin/dict.pl?term=');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'DejaNews','http://www.deja.com/=dnc/getdoc.xp?AN=');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'C2','http://c2.com/cgi/wiki?');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'OpenWiki','http://openwiki.com/?');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'Google','http://www.google.com/search?q=');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'RFC','http://www.faqs.org/rfcs/rfc$1.html');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'Meatball','http://www.usemod.com/cgi-bin/mb.pl?');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'MoinMoin','http://purl.net/wiki/moin/');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'Acronym','http://www.acronymfinder.com/af-query.asp?String=exact&Acronym=');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'Amazon','http://www.amazon.com/exec/obidos/ASIN/');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'Groups','http://groups.google.com/groups?oi=djq&as_q=');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'Whois','http://www.networksolutions.com/cgi-bin/whois/whois?STRING=');
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'HtmlHelp','http://www.htmlhelp.com/cgi-bin/search.cgi?q=');
set term ^;
insert into openwiki_interwikis (wik_name,	wik_url) values (
  'Artist','http://ubl.com/ubl_search.asp?ubl_search=Artist&amp;text=')^
set term ;^

-------------------------------------------------------------------------------
-- openwiki_badlinklist
-------------------------------------------------------------------------------
insert into openwiki_badlinklist (bll_name, bll_comment) values ('songtext-archiv.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('gratisproben.ev.to','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('samsung-klingelton.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.modelcasting-agentur.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('mafia-cheats.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('malvorlagen.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('nokia-klingeltoene.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('siemens-klingeltoene.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('ps2-cheats.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('samsung-klingeltoene.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('nokia-handylogo.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('siemens-handylogo.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('gratis-proben.ev.to','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('gta-3-cheats.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('samsung-handylogo.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('malvorlagen.de.tp','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('neue.klingeltoene.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('neue-klingeltoene.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('neue-klingeltoene.de.tp','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('neue-klingeltoene.de.pn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('warcraft-3-cheats.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('neue-klingeltoene.de.hm','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('neue-klingeltoene.de.gg','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('malvorlagen.de.pn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('waren-proben.ev.to','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.model-casting-agentur.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('handy-java-games.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('handy-games.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('playstation-cheats.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('handy-spiele.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('handyspiele.net.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('handygames.eu.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('handy-javagames.net.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('nokia-klingelton.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('free-ringtone.uk.pn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('handy-handy.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('songtexte-laden.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('sms-sprueche.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('proben.ev.to','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('xbox-cheats.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('sms-spruch.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('sprueche-sms.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('sms.ph.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('sprueche.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('siemens-klingelton.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('handy.ph.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('sms-sms.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('kostenlose.klingeltoene.de.tp','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.modellcasting-agentur.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.kleinanzeigen.de.tt','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('cheats-gta.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.songtexte.eu.pn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('free-ringtone.uk.pn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('songtexte.be.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('toggolino.de.gg','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('bob-baumeister.de.gg','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('kostenlose.klingeltoene.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('medal-of-honor-cheats.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('malvorlage.de.pn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('kostenlose.klingeltoene.de.hm','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('kostenloser-klingelton.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.modell-casting-agentur.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('kostenloser-klingelton.de.tp','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('kostenloser-klingelton.de.hm','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('klingeltoene-kostenlos.de.tp','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('malvorlage.de.tp','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('klingeltoene-kostenlos.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('klingeltoene.kostenlos.de.hm','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('klingelton-kostenlos.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('klingelton-kostenlos.de.tp','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('klingelton.kostenlos.de.hm','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('songtexte.us.tp','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('songtexte-forum.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('malvorlage.de.tc','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('game-cheats.de.sr','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('warenproben.ev.to','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.doli.com.cn ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.bjrealcolor.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.lily-bearing.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.delign.net ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('51pbx.51.net ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.topcel-battery.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.lungan.com.tw ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.bdichina.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.ehyundai.net.cn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.da-tian.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.landray.com.cn ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.jszd.cn ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.brightking.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.noahark.com.cn ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.softxp.net ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.da-tian.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.photel.com.cn ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.ckochina.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.aclas.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.yaxon.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.radi-instrument.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.aclas.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.messagesoft.net','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.glb.com.cn ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.wintec.cn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.fengpu.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.jxedz.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('googleranking.go.nease.net ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('adweb1.51.net ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('adweb2.51.net ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.webi.com.cn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.kaien.com.cn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.weroom.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.cnsem.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.marketingbetter.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.58447575.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.watercooler.com.cn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.haiz.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.hisensors.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.loushi.cn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.showcoo.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.semcn.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.bungee-international.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.efuchina.com ','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('5itour.vip.myrice.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('jipiaowang.freewebpage.org','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('jiudian.freewebpage.org','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.feijp.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.5itour.cn','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('www.5itour.com','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('product.freewebpage.org','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('5itour.freewebpage.org','BadLinkList entry');
insert into openwiki_badlinklist (bll_name, bll_comment) values ('cheap.freewebpage.org','BadLinkList entry');

-------------------------------------------------------------------------------
-- openwiki_categories
-------------------------------------------------------------------------------
delete from openwiki_categories;
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('1','System Page');
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('2','Menu Page');
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('3','Help Page');
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('4','Include Page');
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('5','Protected Edit');
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('6','Testing Page');
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('7','Temporary Page');
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('8','For Comment');
INSERT INTO OPENWIKI_CATEGORIES (KEY_CATEGORIES, CATEGORIES_NAME) VALUES ('9','Deprecate me');

-------------------------------------------------------------------------------
-- openwiki_pages
-------------------------------------------------------------------------------
delete from openwiki_pages;
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'TitleIndex','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'UserPreferences','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'RandomPage','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'Help','1','2','2');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnEmoticons','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnFormatting','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'CategoryHelp','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'CategoryCategory','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnEditing','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'RecentChanges','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpMenu','2','2','2');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnHeaders','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnLinking','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnMacros','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnProcessingInstructions','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnTables','2','2','2');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HelpOnRevisions','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'HomePageTemplate','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'LinkPattern','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'WikiName','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'WikiPage','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'FindPage','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'RandomPages','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'WordIndex','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'WhatIsaWiki','1','1','1');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'FrontPage','3','3','3');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'OpenWiki','2','2','2');
insert into openwiki_pages (wpg_name,	wpg_lastmajor,	wpg_lastminor,	wpg_changes) values (
  'InterWiki','1','1','1');
  
-------------------------------------------------------------------------------
-- openwiki_rss
-------------------------------------------------------------------------------
delete from openwiki_rss;
insert into openwiki_rss (rss_url,rss_last,rss_next,rss_refreshrate,rss_cache) values (
  'http://slashdot.org/slashdot.rdf',
  '3/17/2002 18:30:48',
  '3/17/2002 20:30:48','120',
  '<a href="http://slashdot.org/"><img src="http://images.slashdot.org/topics/topicslashdot.gif" alt="News for nerds, stuff that matters" border="0" /></a><br /><a href="http://slashdot.org/article.pl?sid=02/03/15/1943212" class="rss">Open Source in the Military?</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/15/2213209" class="rss">Java on Handheld Devices?</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/16/0042255" class="rss">Science in the Microwave</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/16/0141215" class="rss">Top Asteroids Scorer Gets Posthomous Award</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/15/2338208" class="rss">Census Bureau Wants 500,000 Handhelds in 2010</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/15/1815238" class="rss">Gravestones Advertising Video Games?</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/15/2329247" class="rss">FCC Petitioned to Restrict 2.4GHz Band</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/16/0125254" class="rss">25 More States Oppose MSFT Antitrust Dismissal</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/15/1319233" class="rss">Mining Unstructured Data</a><br /><a href="http://slashdot.org/article.pl?sid=02/03/15/1923230" class="rss">Tips on Managing Concurrent Development?</a><br /><form action="http://slashdot.org/search.pl" method="post">Search Slashdot:<br /><input type="text" name="query" /></form>');

-------------------------------------------------------------------------------
-- openwiki_rss_aggregations
-------------------------------------------------------------------------------
delete from openwiki_rss_aggregations;
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/15/1319233',
  'http://slashdot.org/article.pl?sid=02/03/15/1319233',
  '3/17/2002 18:30:40','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/15/1319233''><title>Mining Unstructured Data</title><link>http://slashdot.org/article.pl?sid=02/03/15/1319233</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:40+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/15/1815238',
  'http://slashdot.org/article.pl?sid=02/03/15/1815238',
  '3/17/2002 18:30:43','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/15/1815238''><title>Gravestones Advertising Video Games?</title><link>http://slashdot.org/article.pl?sid=02/03/15/1815238</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:43+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/15/1923230',
  'http://slashdot.org/article.pl?sid=02/03/15/1923230',
  '3/17/2002 18:30:39','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/15/1923230''><title>Tips on Managing Concurrent Development?</title><link>http://slashdot.org/article.pl?sid=02/03/15/1923230</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:39+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/15/1943212',
  'http://slashdot.org/article.pl?sid=02/03/15/1943212',
  '3/17/2002 18:30:48','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/15/1943212''><title>Open Source in the Military?</title><link>http://slashdot.org/article.pl?sid=02/03/15/1943212</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:48+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/15/2213209',
  'http://slashdot.org/article.pl?sid=02/03/15/2213209',
  '3/17/2002 18:30:47','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/15/2213209''><title>Java on Handheld Devices?</title><link>http://slashdot.org/article.pl?sid=02/03/15/2213209</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:47+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/15/2329247',
  'http://slashdot.org/article.pl?sid=02/03/15/2329247',
  '3/17/2002 18:30:42','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/15/2329247''><title>FCC Petitioned to Restrict 2.4GHz Band</title><link>http://slashdot.org/article.pl?sid=02/03/15/2329247</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:42+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
'http://slashdot.org/slashdot.rdf',
'http://slashdot.org/article.pl?sid=02/03/15/2338208',
'http://slashdot.org/article.pl?sid=02/03/15/2338208',
'3/17/2002 18:30:44','',
'<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/15/2338208''><title>Census Bureau Wants 500,000 Handhelds in 2010</title><link>http://slashdot.org/article.pl?sid=02/03/15/2338208</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:44+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/16/0042255',
  'http://slashdot.org/article.pl?sid=02/03/16/0042255',
  '3/17/2002 18:30:46','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/16/0042255''><title>Science in the Microwave</title><link>http://slashdot.org/article.pl?sid=02/03/16/0042255</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:46+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/16/0125254',
  'http://slashdot.org/article.pl?sid=02/03/16/0125254',
  '3/17/2002 18:30:41','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/16/0125254''><title>25 More States Oppose MSFT Antitrust Dismissal</title><link>http://slashdot.org/article.pl?sid=02/03/16/0125254</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:41+01:00</ag:timestamp></item>');
insert into openwiki_rss_aggregations(
  agr_feed, agr_resource, agr_rsslink, agr_timestamp, agr_dcdate, agr_xmlisland) values (
  'http://slashdot.org/slashdot.rdf',
  'http://slashdot.org/article.pl?sid=02/03/16/0141215',
  'http://slashdot.org/article.pl?sid=02/03/16/0141215',
  '3/17/2002 18:30:45','',
  '<item rdf:about=''http://slashdot.org/article.pl?sid=02/03/16/0141215''><title>Top Asteroids Scorer Gets Posthomous Award</title><link>http://slashdot.org/article.pl?sid=02/03/16/0141215</link><ag:source>Slashdot</ag:source><ag:sourceURL>http://slashdot.org/</ag:sourceURL><ag:timestamp>2002-03-17T18:30:45+01:00</ag:timestamp></item>');

set term ^;
-------------------------------------------------------------------------------
-- openwiki_revisions
-------------------------------------------------------------------------------

insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'TitleIndex','1','1','1','3/17/2002 18:05:38','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<TitleIndex>')^
set term ;^

set term ^;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'UserPreferences','1','1','1','3/17/2002 18:05:51','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<UserPreferences>')^
set term ;^

set term ^;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'RandomPage','1','1','1','3/17/2002 18:06:01','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','#RANDOMPAGE')^
set term ;^

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'Help','1','0','1','3/17/2002 18:22:05','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','The following is a list of help pages:

<TitleSearch(^Help[A-Z])>

----

CategoryHelp')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'Help','2','1','1','3/17/2002 18:22:12','1','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','The following is a list of help pages:

<TitleSearch(^Help[A-Z])>


----
CategoryHelp')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnFormatting','1','1','1','3/17/2002 18:23:27','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>
OpenWiki offers many system options to the administrator of an OpenWiki site, so the formatting rules may differ between various OpenWiki sites.
This particular wiki has every system option turned on except the one that would give editors the ability to enter raw HTML into a page (with some minor exceptions to that exception  ;-) ).
<TableOfContents/>
=== The Basics ===
  * Forget HTML. It is not allowed. So <b>bold</b> will not appear in a bold font, but instead as you see it right now. The & character references will not work either.
  * Do not indent paragraphs.
  * Words wrap and fill as needed.
  * Leave a blank line between paragraphs.
  * Type 4 or more minus/dash/hyphen (-) characters to create a horizontal rule.
  * URL''s and email addresses are automatically hyperlinked.
  * WikiName""s are automatically hyperlinked. A WikiName conforms to the LinkPattern, which basically is a word containing more than one capital letter where the capitals aren''t right next to each other. In other words, simply SmashWordsTogetherLikeSo.
That''s basically all you need to know to get started. Following are more basic rules. For advanced formatting rules see HelpOnEditing.
=== Bold, Italic, Underscore, Strikethrough ===
To mark text as **bold** enclose text by two asterisks <nowiki>(*)</nowiki> characters on both sides.
To mark text as //italic// enclose text by two slash (/) characters on both sides.
To mark text __underlined__ enclose text by two underscore (_) characters on both sides.
To mark text --strikethrough-- enclose text by two dash (-) characters on both sides.
{{{
**Some bold text**, //some italic text//, and **//some bold and italic text//**
__Some underlined text__ --Some strikethrough text--
}}}
will appear as:
**Some bold text**, //some italic text//, and **//some bold and italic text//**
<br/>
__Some underlined text__ --Some strikethrough text--
~OpenWiki also supports the "old" style of placing emphasis on text which is used by several original wikis.
{{{
<nowiki>''''2 quotes are italic'''', ''''''3 quotes are bold'''''', and ''''''''''5 quotes are bold and italic''''''''''</nowiki>
}}}
will appear as:
''''2 quotes are italic'''', ''''''3 quotes are bold'''''', and ''''''''''5 quotes are bold and italic''''''''''
Note: whether the "new" and/or "old" style of placing emphasis on text is in effect depends on the system options as configured by the administrator of this site.
=== Linking ===
See also HelpOnLinking.
InterWiki links, e.g.:
  * Whois:moonshake.com
  * Google:Aphex+Twin
  * Dictionary:GuineaPig
  * Artist:Radiohead
  * ISBN: 0-898-15627-0
  * RFC:821
  * Groups:alt.delete.this.group
  * Acronym:HTML
  * HtmlHelp:FORM
=== Lists ===
All lists start with 2 spaces at the beginning of a line. Sublists are created by adding an additional 2 spaces for every level that you want to add. See also HelpOnLists.
==== Bulleted Lists ====
{{{
  * Bulleted Item
  * Another one
    * Subbulleted item
    * And another one
  * Last one
}}}
will appear as:
  * Bulleted Item
  * Another one
    * Subbulleted item
    * And another one
  * Last one
==== Numbered Lists ====
{{{
  1. First item
  2. Second item
    1. First subitem of //second item//
    1. Second subitem of //second item//
      a. subitem a
      a. subitem b
    1. Third subitem of //second item//
      i. subitem 1
      i. subitem 2
  3. Third item
    1.#17 another item
    1. yet another one
  4. Fourth item
    a.#17 another item
    a. yet another one
  5. Fifth item
    i.#17 another item
    i. yet another one
}}}

will appear as:

  1. First item
  2. Second item
    1. First subitem of //second item//
    1. Second subitem of //second item//
      a. subitem a
      a. subitem b
    1. Third subitem of //second item//
      i. subitem 1
      i. subitem 2
  3. Third item
    1.#17 another item
    1. yet another one
  4. Fourth item
    a.#17 another item
    a. yet another one
  5. Fifth item
    i.#17 another item
    i. yet another one

==== Dictionary Lists ====

Terms with indented definitions: [without a blank line between term and definition]
{{{
  ; Term One : Definition for One (indented)
  ; Term Two : Definition for Two (indented)
  ; Term Three : Definition for Three (indented)
    ; Term (indented) : Definition (indented two levels)
      ; Term (indented twice) : Definition (indented to third level)
}}}

will appear as:

  ; Term One : Definition for One (indented)
  ; Term Two : Definition for Two (indented)
  ; Term Three : Definition for Three (indented)
    ; Term (indented) : Definition (indented two levels)
      ; Term (indented twice) : Definition (indented to third level)


==== Mixing Lists ====
You can also mix lists, for example:

{{{
  * First bulleted item
  * Second bulleted item
    1. First subitem of **second item**
       Some more text about first subitem....
       End of this subitem.
    2. Second subitem of **second item**
  * Last bulleted item
}}}

will appear as:

  * First bulleted item
  * Second bulleted item
    1. First subitem of **second item**
       Some more text about first subitem....
       End of this subitem.
    2. Second subitem of **second item**
  * Last bulleted item


=== Indented text ===

{{{
  : Paragraph to be indented (quote-block)
    : Paragraph indented more
      : Paragraph indented to third level
}}}

will appear as:

  : Paragraph to be indented (quote-block)
    : Paragraph indented more
      : Paragraph indented to third level


=== Preformatted text ===


=== Sourcecode ===

If you want to display sourcecode use the {{{<code>}}} tag or enclose the source by three acolades (e.g. <nowiki>{{{some code}}}</nowiki>).

Singleline example:
{{{
<nowiki>The command {{{foo := bar + 1;}}} will add 1 to bar and assign it to foo.</nowiki>
}}}

will appear as:

The command {{{foo := bar + 1;}}} will add 1 to bar and assign it to foo.

Multiline example:
{{{
<nowiki>{{{
begin
    foo := bar + 1;
end;
}}}</nowiki>
}}}

will appear as:

{{{
begin
    foo := bar + 1;
end;
}}}

Note that within sourcecode most features won''t work, such as: automatic hyperlinking of URLs, WikiName''''''''''''s, making text italic, etc. What still does work within sourcecode is the ability to highlight text by using three single quotes and the ability to use the {{{<nowiki><</nowiki>nowiki>}}} tag.

Example:
{{{
<nowiki><code>
begin
    ''''''foo := bar + 1;''''''
    foo := foo << 1;
    return foo;
end;
</code></nowiki>
}}}

will appear as:

<code>
begin
    ''''''foo := bar + 1;''''''
    foo := foo << 1;
    return foo;
end;
</code>

=== Tables ===

{{{
|| **ID** || **Name** || **Description** ||
|| 123 || John Foo || Some foo user ||
|| 456 || Mary Richardson || Contact person from Foo Corp. ||
}}}

will appear as:

|| **ID** || **Name** || **Description** ||
|| 123 || John Foo || Some foo user ||
|| 456 || Mary Richardson || Contact person from Foo Corp. ||


From more details about how to format tables see HelpOnTables.

=== Miscellaneous ===


----
CategoryHelp')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'CategoryHelp','1','1','1','3/17/2002 18:24:02','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','A category for the pages that are part of the [[Help]] system.

==== Current Help Pages ====
<TitleSearch(^Help)/>

----
CategoryCategory')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'CategoryCategory','1','1','1','3/17/2002 18:24:13','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','== All Known Categories ==

<TitleSearch(^Category)/>')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnEditing','1','1','1','3/17/2002 18:24:57','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>

Double-click on any page to enter edit mode. Any person can edit any page. Any person at all, in fact!

In edit mode you will see the page contents inside a large text box. You may add/edit/update/delete any information within this box. See HelpOnFormatting for the syntax.

Three buttons are at the top of the page:

  * **Save:** Saves the current page as a new revision.
  * **Preview:** Reloads the edit page and shows below the edit box the proposed changes as they would appear if saved.
  * **Cancel:** Cancels edit mode and returns you to the page you were viewing.

Below the text box you will see a checkbox with the text ''''Include page in RecentChanges list''''. If this box is checked, the edits you make will be logged as a major revision and will show up in the standard RecentChanges list. If un-checked, the edit is logged as a minor revision and does not show up on the default RecentChanges view. Minor edits will only appear if the <code>filter</code> querystring parameter is set to <code>2</code>. 

Next is a long text box with the label ''''Optional comment about this change''''. Anything you type in here will show up as a comment in the RecentChanges view entry for the edited page.

Finally you see the same three buttons (''''Save'''', ''''Preview'''', ''''Cancel'''') that are discussed above.')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'RecentChanges','1','1','1','3/17/2002 18:26:23','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','[This:RecentChanges major edits]
[This:RecentChanges&filter=2 minor edits]
[This:RecentChanges&filter=3 minor & major edits]
<br>
[This:RecentChanges&days=7 last 7 days]
[This:RecentChanges&days=30 last 30 days]
[This:RecentChanges&days=90 last 90 days]
<br>
[This:RecentChanges&days=7&filter=3 minor & major edits of last 7 days]
----
<RecentChangesLong>')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpMenu','1','0','1','3/17/2002 18:27:35','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','**Help On:** [HelpOnEditing Editing] | [HelpOnFormatting Formatting] | [HelpOnEmoticons Emoticons] | [HelpOnHeaders Headers] | [HelpOnLinking Linking] | [HelpOnMacros Macros] | [HelpOnMathML MathML] | [HelpOnProcessingInstructions Processing Instructions] | [HelpOnTables Tables]
----')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnHeaders','1','1','1','3/17/2002 18:28:02','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>

{{{
= Header 1 =
== Header 2 ==
=== Header 3 ===
==== Header 4 ====
===== Header 5 =====
}}}

= Header 1 =
== Header 2 ==
=== Header 3 ===
==== Header 4 ====
===== Header 5 =====
')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnLinking','1','1','1','3/17/2002 18:30:16','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>

<code>
''''''Wiki Links''''''
x1 NonExistentPage x1
x2 FrontPage x2
x3 [NonExistentPage] x3
x4 [FrontPage] x4
x5 [NonExistentPage Non Existent Page] x5
x5b [FrontPage FrontPage] x5b
x6 [FrontPage Our Front Page] x6
x7 /NonExistentSubpage x7
x8 /ExistentSubpage x8
x9 [/NonExistentSubpage] x9
x10 [/ExistentSubpage] x10
x11 [/NonExistentSubpage Non existent subpage] x11
x11b [/ExistentSubpage /ExistentSubpage] x11b
x12 [/ExistentSubpage out front subpage] x12
x13 /ExistentSubpage/SubPage1/SubPage2/SubPage3
x14 ./NonExistentRelativeSubpage x14
x15 ~DoNotLinkThisWord x15
</code>
<pre>
''''''Wiki Links''''''
x1 NonExistentPage x1
x2 FrontPage x2
x3 [NonExistentPage] x3
x4 [FrontPage] x4
x5 [NonExistentPage Non Existent Page] x5
x5b [FrontPage FrontPage1] x5b
x6 [FrontPage Our Front Page] x6
x7 /NonExistentSubpage x7
x8 /ExistentSubpage x8
x9 [/NonExistentSubpage] x9
x10 [/ExistentSubpage] x10
x11 [/NonExistentSubpage Non existent subpage] x11
x11b [/ExistentSubpage /ExistentSubpage] x11b
x12 [/ExistentSubpage out front subpage] x12
x13 /ExistentSubpage/SubPage1/SubPage2/SubPage3
x14 ./NonExistentRelativeSubpage x14
x15 ~DoNotLinkThisWord x15
</pre>

----

<code>
''''''Url Links''''''
x1 http://www.openwiki.com x1
x2 news://alt.useless.newsgroup.delete.me. x2
x2b <foo>http://www.openwiki.com</foo> x2b
x2c <foo>http://www.openwiki.com""</foo> x2c
x3 [http://www.openwiki.com] x3
x4 [http://www.openwiki.com ] x4
x5 [http://www.openwiki.com OpenWiki] x5
x6 [http://www.openwiki.com Openwiki Test Link] x6
x7 [http://www.openwiki.com Openwiki Test Link ] x7
x8 [ http://www.openwiki.com Openwiki Test Link] x8
x9 laurens@openwiki.com x9
x10 mailto:laurens@openwiki.com x10
x11 [mailto:laurens@openwiki.com] x11
x12 [mailto:laurens@openwiki.com Laurens Pit] x12
x13 http://www.aspxp.com/images/aspxp.gif x13
x13b [http://www.aspxp.com http://www.aspxp.com/images/aspxp.gif] x13b
x14 [http://www.aspxp.com/images/aspxp.gif] x14
x15 [http://www.aspxp.com/images/aspxp.gif ASP XP] x15
x16 <a href="http://www.aspxp.com">ASP XP</a> x16
x17 <a href="http://www.aspxp.com" class="nonexistent">ASP XP</a> x17
x18 http://www.test.com/test.asp?x=0&y=1 x18
x19 [http://www.test.com/test.asp?x=0&y=1 test.com] x19
</code>
<pre>
''''''Url Links''''''
x1 http://www.openwiki.com x1
x2 news://alt.useless.newsgroup.delete.me. x2
x2b <foo>http://www.openwiki.com</foo> x2b
x2c <foo>http://www.openwiki.com""</foo> x2c
x3 [http://www.openwiki.com] x3
x4 [http://www.openwiki.com ] x4
x5 [http://www.openwiki.com OpenWiki] x5
x6 [http://www.openwiki.com Openwiki Test Link] x6
x7 [http://www.openwiki.com Openwiki Test Link ] x7
x8 [ http://www.openwiki.com Openwiki Test Link] x8
x9 laurens@openwiki.com x9
x10 mailto:laurens@openwiki.com x10
x11 [mailto:laurens@openwiki.com] x11
x12 [mailto:laurens@openwiki.com Laurens Pit] x12
x13 http://www.aspxp.com/images/aspxp.gif x13
x13b [http://www.aspxp.com http://www.aspxp.com/images/aspxp.gif] x13b
x14 [http://www.aspxp.com/images/aspxp.gif] x14
x15 [http://www.aspxp.com/images/aspxp.gif ASP XP] x15
x16 <a href="http://www.aspxp.com">ASP XP</a> x16
x17 <a href="http://www.aspxp.com" class="nonexistent">ASP XP</a> x17
x18 http://www.test.com/test.asp?x=0&y=1 x18
x19 [http://www.test.com/test.asp?x=0&y=1 test.com] x19
</pre>

----

<code>
''''''ISBN numbers''''''
x17 ISBN:0-1234-56789 x17
y17 ISBN: 0-1234-56789 y17
x18 ISBN:  1234-56789-X x18
y18 ISBN:  12 34-56 -  789-X y18
z18 ISBN:  12 34-56 -  789-X-3043 z18
x19 [ISBN: 1234567] x19
x20 [ISBN: 123456789-X] x20
x21 [ISBN: 1234567-89-x BookTitle] x21
x22 [ISBN: 1234567-89-x Flowers, and why they grow] x22
x23 [ISBN: 1234567-893434343-x Flowers, and why they grow] x23
</code>
<pre>
''''''ISBN numbers''''''
x17 ISBN:0-1234-56789 x17
y17 ISBN: 0-1234-56789 y17
x18 ISBN:  1234-56789-X x18
y18 ISBN:  12 34-56 -  789-X y18
z18 ISBN:  12 34-56 -  789-X-3043 z18
x19 [ISBN: 1234567] x19
x20 [ISBN: 123456789-X] x20
x21 [ISBN: 1234567-89-x BookTitle] x21
x22 [ISBN: 1234567-89-x Flowers, and why they grow] x22
x23 [ISBN: 1234567-893434343-x Flowers, and why they grow] x23
</pre>

----

<code>
''''''Free Links''''''
x1 [[nonexistent free link page]] x1
x2 [[existing page, ((You can add ''''Special-characters]] x2
x3 [[free link page|some title]] x3
x4 [[free link page | some title]] x4
x5 [[free link page | some | title]] x5
</code>
<pre>
''''''Free Links''''''
x1 [[nonexistent free link page]] x1
x2 [[existing page, ((You can add ''''Special-characters]] x2
x3 [[free link page|some title]] x3
x4 [[free link page | some title]] x4
x5 [[free link page | some | title]] x5
</pre>

----

<code>
''''''Inter Links''''''
x1 Dictionary:Bird x1
x2 dictionary:Bird x2
x3 [Dictionary:Bird] x3
x4 [Dictionary:Bird Birdies] x4
x5 [Dictionary:Bird It''s a Bird!] x5
x6 [DictionaryList:Bird It''s a Bird!] x6
x7 DictionaryList:Bird It''s a Bird! x7
x8 C2:WhatIsAWiki x8

  * Whois:openwiki.com
  * Google:Aphex+Twin
  * Dictionary:GuineaPig
  * Artist:Radiohead
  * ISBN: 0-898-15627-0
  * RFC:821
  * Groups:alt.delete.this.group
  * Acronym:HTML
  * HtmlHelp:FORM
  * Whatis:Ethernet
  * Everything:Ethernet
</code>
<pre>
''''''Inter Links''''''
x1 Dictionary:Bird x1
x2 dictionary:Bird x2
x3 [Dictionary:Bird] x3
x4 [Dictionary:Bird Birdies] x4
x5 [Dictionary:Bird It''s a Bird!] x5
x6 [DictionaryList:Bird It''s a Bird!] x6
x7 DictionaryList:Bird It''s a Bird! x7
x8 C2:OpenWiki x8

  * Whois:openwiki.com
  * Google:Aphex+Twin
  * Dictionary:GuineaPig
  * Artist:Radiohead
  * ISBN: 0-898-15627-0
  * RFC:821
  * Groups:alt.delete.this.group
  * Acronym:HTML
  * HtmlHelp:FORM
  * Whatis:Ethernet
  * Everything:Ethernet
</pre>
See InterWiki for more possible inter links.')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnMacros','1','1','1','3/17/2002 18:30:49','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>

=== Introduction ===

OpenWiki recognizes a few macro names. A macro is recognized as such if its name appears between a pair of <...>''s characters (<.../> is also accepted).
<br> 
E.g. {{{<TableOfContents>}}} and {{{<TableOfContents />}}} are macro''s. 

Some macro''s accept one or more parameters. Parameters are given directly following the macroname and are enclosed between a pair of (...)''s characters. Mulitple parameters are separated by comma''s. 
<br>
E.g. {{{<FullSearch("^Help")>}}}, {{{<RecentChanges(10,30)>}}}.

All known macro''s that are supported by OpenWiki are described below.



=== Table Of Contents ===

To show the table of contents of a page use the macro {{{<TableOfContents>}}}. This table is created by looking at all the [HelpOnHeaders headers] used within a page.
<code>
<TableOfContents>
</code>
<TableOfContents>


=== Line Break ===

By default OpenWiki ignores linebreaks. Actually it''s a feature of all web browsers which OpenWiki simply inherits. If you want a line directly followed by a new line then you can use the macro {{{<br>}}}. Below you see an example which shows the difference:
<code>
this is line one.
is this line two?

this is line one. <br>
is this line two?
</code>
this is line one.
is this line two?

this is line one. <br>
is this line two?


=== Including Pages ===

One of the more powerful macro''s is the {{{<Include>}}} macro. Using this macro you can include another wiki page into the current wiki page. This is great if for example you want to use a common menu structure for a subset of your wiki. See for example MyProject.

Pass the name of the WikiPage you want to include, e.g.:
<code>
<Include(MyProjectMenu)>
</code>
<Include(MyProjectMenu)>



=== Anchors ===

You can put invisible anchors in your page by using the {{{<Anchor>}}} macro. Pass the name of the anchor as a parameter, e.g.:
<code> 
<Anchor(MyAnchor)> This piece of text is anchored.
</code>
<Anchor(MyAnchor)> This piece of text is anchored.




=== Searches ===

To show an input editbox that will do a search through all the titles of the pages in this wiki use the macro {{{<TitleSearch>}}}. Below an example is shown:
<code>
Title search: 
<TitleSearch>
</code>
Title search: 
<TitleSearch>

The {{{<TitleSearch>}}} macro also accepts a parameter. Instead of showing an editbox it will then show a list of page titles that match the pattern of the parameter. E.g.:
<code>
List of all the help page (assuming all these start with the letters "Help"):
<TitleSearch(^Help)>
</code>
List of all the help page (assuming all these start with the letters "Help"):
<TitleSearch(^Help)>


To show an input editbox that will do a full text search through all the pages in this wiki use the macro {{{<FullSearch>}}}. Below an example is shown:
<code>
Full text search: 
<FullSearch>
</code>
Full text search: 
<FullSearch>

The {{{<FullSearch>}}} macro also accepts a parameter. Instead of showing an editbox it will then do a full text search through all the pages and show a list of the pages that match the pattern of the parameter. E.g.:
<code>
List all pages containing the word "Text Search":
<FullSearch("Text Search")>
</code>
List all pages containing the word "Text Search":
<FullSearch("Text Search")>


To show an input editbox that will allow you to go to a page or create a new page by entering it''s name in the editbox use the macro {{{<GoTo>}}}. 
<code>
<GoTo>
</code>
<GoTo>


=== Indexes ===

To view a list of all the pages in this wiki use the macro {{{<TitleIndex>}}}. See TitleIndex for an example.

To view a list of all the words used in the titles of wiki pages use the macro {{{<WordIndex>}}}. See WordIndex for an example.

To view a list of recently changed pages use the macro {{{<RecentChanges>}}}. When no parameters are provided all pages changed in the last 30 days will be shown. See for example the RecentChanges page.

One or two paramterers are accepted. The first parameter is the maximum number of days that should be shown in the change list. The second parameter is the maximum number of page titles that should be shown in the change list. When a parameter is not a number or less or equal than zero, then a default value is taken.

The example below will show all recently changed pages in the last 24 hours.
<code>
<RecentChanges(1)/>
</code>
<RecentChanges(1)/>

The example below will show a maximum of 10 recently changed pages.
<code>
<RecentChanges(0,10)/>
</code>
<RecentChanges(0,10)/>

For more information about recently changed pages and how revisions work see HelpOnRevisions.




=== Random Pages ===

To show a random page link use the macro {{{<RandomPage>}}}. Below a random page link is shown:
<code>
<RandomPage>
</code>
<RandomPage>

To show a number of random page links, pass the number as a parameter to the macro. For example, below 5 random page links are shown by using the macro {{{<RandomPage(5)>}}}:
<code>
<RandomPage(5)>
</code>
<RandomPage(5)>


=== Syndication ===

News related sites often offer a so-called RSS feed. This feed is available through a URL. For example, the latest news headlines from [http://slashdot.org Slashdot] are retrievable through the URL http://slashdot.org/slashdot.rdf.

It''s possible to syndicate these news headlines into OpenWiki. To do this use the macro {{{<Syndicate>}}}. This macro needs at least one parameter, the second parameter is optional. The first parameter must be the URL to the RSS feed enclosed by quotes. The second parameter must be a number (in minutes) which tells how often to refresh the news, where the default is 120 minutes or 2 hours. Retrieving the news headlines is a costly operation so you don''t want to set the refresh rate too low.

Example:
<code>
<Syndicate("http://slashdot.org/slashdot.rdf", 120)> 
</code>
<Syndicate("http://slashdot.org/slashdot.rdf", 120)> 

Use of this macro can be disabled by the system administrator.

For more information about RSS see RDFSiteSummary.



=== Aggregation ===

Just as you can syndicate RSS feeds into a wiki page, it''s possible to aggregate multiple RSS feeds into one list. Define all the RSS feeds you want to aggregate using the {{{Syndicate}}} macro, put all these definitions in one wiki page, and then use the macro {{{Aggregate}}} in any wiki page to aggregate the RSS feeds defined in the wiki page with the {{{Syndicate}}} macro''s.

This macro needs one parameter, which must be the name of the wiki page containing the {{{Syndicate}}} macro''s.

Example:
<code>
<Aggregate("AllTheNews")> 
</code>

To view the results of this example, see AllTheNews and AllTheNews/Aggregation.

Use of this macro can be disabled by the system administrator.




=== User Preferences ===

To show the user preferences use the macro {{{<UserPreferences>}}}. See for example the page UserPreferences.



=== Inter Wiki ===

To show the list of known InterWiki''''''''''''s use the macro {{{<InterWiki>}}}.
<code>
<InterWiki>
</code>
<InterWiki>




=== System Info ===

Below information about this system is shown:
<code>
<SystemInfo>
</code>
<SystemInfo>

<code>
<PageCount>
</code>
This wiki contains **<PageCount>** WikiPage''''''''''''s.

<code>
<Date> <Time> <DateTime>
</code>
The date on this server is <Date>

The time on this server is <Time>

The datetime on this server is <DateTime>

')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpMenu','2','1','1','3/17/2002 18:31:11','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','**Help On:** [HelpOnEditing Editing] | [HelpOnFormatting Formatting] | [HelpOnEmoticons Emoticons] | [HelpOnHeaders Headers] | [HelpOnLinking Linking] | [HelpOnMacros Macros] | [HelpOnProcessingInstructions Processing Instructions] | [HelpOnTables Tables]
----')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnProcessingInstructions','1','1','1','3/17/2002 18:31:28','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>

Processing instructions control how a page is processed. Processing instructions must be entered at the first line, start with a hash ({{{#}}}) character followed by a keyword in capital letters and optionally followed by a space and an argument. Below are the processing instructions recognized by OpenWiki.

<TableOfContents/>


=== #REDIRECT ===
The syntax for this processing instruction is:
{{{
    #REDIRECT <PageName>
}}}
If this processing instruction appears on the first line of a page the contents of the page will not be shown, instead you will be redirected to the page {{{<PageName>}}}. This is useful because it allows similar pagenames to share the same page content. Redirections are not recursive, only the first redirection will be used.

Example: if you go to WikiSandBox you will be redirected to SandBox.

Editing a redirected page is easy. In the above example, after you''ve been redirected, simply click on the title WikiSandBox and you''re in the edit mode of that page. Click on the "Preview" button if you then want to see the page as it would look like if it wasn''t redirected.


=== #RANDOMPAGE ===
This is a special case of the {{{#REDIRECT}}} processing instruction. If the {{{#RANDOMPAGE}}} processing instruction appears on the first line of a page you will be redirected to a random page.

<Anchor("deprecated")>
=== #DEPRECATED ===
The {{{#DEPRECATED}}} processing instruction is used to mark a page as being deprecated. A deprecated page will be deleted after a certain number of days (determined by the administrator of this website).

When you deprecate a page you should remove and/or change all references to the page. You can find all the references to the deprecated page by clicking on it''s title at the top.

You can see which pages are deprecated and about to be destroyed permanently by entering the string {{{^#DEPRECATED}}} in the Find box below a page and hitting the search button. Or see DeprecatedPages.

----
CategoryHelp')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnTables','1','0','1','3/17/2002 18:31:39','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>

<code>
|| **ID** || **Name** || **Description** ||
|| 123 || John Foo || Some foo user ||
|| 456 || Mary Richardson || Contact person from Foo Corp. ||
</code>

|| **ID** || **Name** || **Description** ||
|| 123 || John Foo || Some foo user ||
|| 456 || Mary Richardson || Contact person from Foo Corp. ||

You can also insert columns that span more than one column, like:

<code>
|||||||| ''''''''''Contact persons'''''''''' ||
|| **ID** |||| **Name** || **Description** ||
|| 123 || John || Foo || Some foo user ||
|| 456 || Mary || Richardson || Contact person from Foo Corp. ||
</code>

|||||||| ''''''''''Contact persons'''''''''' ||
|| **ID** |||| **Name** || **Description** ||
|| 123 || John || Foo || Some foo user ||
|| 456 || Mary || Richardson || Contact person from Foo Corp. ||



----
CategoryHelp')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnTables','2','1','1','3/17/2002 18:32:35','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>

<code>
|| **ID** || **Name** || **Description** ||
|| 123 || John Foo || Some foo user ||
|| 456 || Mary Richardson || Contact person from Foo Corp. ||
</code>

|| **ID** || **Name** || **Description** ||
|| 123 || John Foo || Some foo user ||
|| 456 || Mary Richardson || Contact person from Foo Corp. ||

You can also insert columns that span more than one column, like:

<code>
|||||||| <nowiki>''''''''''Contact persons''''''''''</nowiki> ||
|| **ID** |||| **Name** || **Description** ||
|| 123 || John || Foo || Some foo user ||
|| 456 || Mary || Richardson || Contact person from Foo Corp. ||
</code>

|||||||| ''''''''''Contact persons'''''''''' ||
|| **ID** |||| **Name** || **Description** ||
|| 123 || John || Foo || Some foo user ||
|| 456 || Mary || Richardson || Contact person from Foo Corp. ||



----
CategoryHelp')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnRevisions','1','1','1','3/17/2002 18:33:47','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','=== Explanation of How Revisions are Managed ===

==== Introduction ====

Every time you edit a page a new revision is created. To view all revisions of a page simply click on the __View other revisions__ link below each page. You can always go back to a previous revision by simply choosing that revision, edit it and save it.


==== Revisions ====

Looking at the address bar of your browser you can see the name of this WikiPage. When viewing a previous revision of this page you''ll see the URL looks something like this:
  http://openwiki.com/ow.asp?p=HelpOnRevisions&revision=2
clicking on this link would show revision 2 of the page HelpOnRevisions.


==== Difference ====

To show the changes between revisions of a page you can use the following parameters to control the output:

  * a        : must have value {{{diff}}}
  * difffrom : the first revision to consider (default is 0)          
  * diffto   : the last revision to consider (default is the current revision)
  * diff     : type of difference (default is 0)
    * 0 = show difference of previous major revision relative to diffto
    * 1 = show difference of previous minor revision relative to diffto
    * 2 = show difference of previous author edit relative to diffto
E.g.: 
  * http://openwiki.com/ow.asp?p=OpenWiki&a=diff 
    shows the difference from prior major revision relative to the current revision.
  * http://openwiki.com/ow.asp?p=OpenWiki&a=diff&diff=2&difffrom=3&diffto=9 
    shows the difference from prior author revision where only revisions 3 to 9 are taken into account.


==== Recent Changes ====

When editing a page you can use a checkbox labeled "Include page in RecentChanges list.". 

If you check this box and save the page then the page will be marked as a "major" revision and will show up in the default listing of RecentChanges. 

If you uncheck this box and save the page then the page will be marked as a "minor" revision and not show up in the default listing of RecentChanges. 

It is possible to view all recent changes including minor edits, or even to view only minor edits and no major edits. The parameter {{{filter}}} is used to control this aspect:

  * filter=1 : show only major edits (is the default)
  * filter=2 : show only minor edits
  * filter=3 : show major and minor edits

Other parameters to control the recent changes output are:

  * days : show only recentchanges of the last {{{days}}}
  * max : show a maximum of {{{max}}} recent changes

E.g. http://openwiki.com/ow.asp?p=RecentChanges&days=60&max=30&filter=3 shows a maximum of 30 recent changes in the last 60 days, showing major and minor edits.
')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HomePageTemplate','1','1','1','3/17/2002 18:34:12','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','=== Your Name ===

  * email: my@domain.com

... 


----
CategoryHomePage
')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'LinkPattern','1','1','1','3/17/2002 18:34:50','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','The LinkPattern defines the rule what pattern a WikiName should follow in order for the WikiName to be hyperlinked automatically to another WikiPage. For all other ways to create hyperlinks see HelpOnLinking.

The link pattern is: one or more uppercase letters, then one or more lowercase letters, then one uppercase letter, then any letters (either upper or lowercase). 

In other words, simply SmashWordsTogetherLikeSo.

The LinkPattern may differ between various Open Wiki sites. Some may allow/disallow digits and underscores, and some may allow/disallow non-English characters.

Note that a WikiName that conforms to the LinkPattern is //not// hyperlinked when the WikiName is equal to the current page title you are viewing. For instance, the word Link''''''Pattern is a WikiName because it follows the pattern, yet it is not hyperlinked.')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'WikiName','1','1','1','3/17/2002 18:35:13','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','A WikiName is a word that follows the LinkPattern. WikiName""s are automatically hyperlinked, except when their name is the same as the current page title.

When a question mark appears after a WikiName then this means the page has not been defined yet. Then you have two options:
  * Click on the question mark, and you will be able to submit a definition for the page. Click on the Cancel button to get into the view mode of that page.
  * Click on the hyperlinked WikiName, which will get you into the view mode of that page. You will then be able to:
    * Click on the pagetitle to see which pages already refer to that WikiName.
    * Click on the "Describe this page" link to submit a definition for the page.
    * Choose one of the templates to start editing with.

If you don''t want to see a WikiName hyperlinked you have several options:
  * Don''t smash the words together, simply put spaces between them.
  * Use the C2:SixSingleQuotes sequences. E.g. {{{Wiki''''''''''Page}}} will result in Wiki''''''''''''Page.
  * Use a tilde (~) character in front of the name. E.g. {{{~WikiPage}}} will result in ~WikiPage.
  * Use the {{{<nowiki}}}{{{>}}} tag. E.g. {{{<nowiki}}}{{{>WikiPage</nowiki>}}} will result in <nowiki>WikiPage</nowiki>.

If you want to hyperlink the singular form of a WikiName that is in the plural form you have two options:
  * Use the C2:SixSingleQuotes sequence. E.g. {{{WikiPage''''''''''''s}}} will result in WikiPage''''''''''''s.
  * Use the double quote. E.g. {{{WikiPage""s}}} will result in WikiPage""s.

----

A WikiName can appear in the bracketed form. For example: {{{[WikiPage my wiki page]}}} would result in [WikiPage my wiki page] which is hyperlinked to WikiPage. This way of hyperlinking to WikiPage""s is a system option configured by the administrator of this site, so it might not work here.



')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'WikiPage','1','1','1','3/17/2002 18:35:38','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','A page on a wiki. Like this one.

Each page has a title. 

todo: explanation about page title rules (free linking, etc.)

WikiLink')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'FindPage','1','1','1','3/17/2002 18:37:14','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','You can use this page to search all entries in this wiki. Searches are not case sensitive.

Good starting points to explore this wiki are:
  * RecentChanges: see where people are currently working on
  * RandomPages: find interesting things that are not on the daily radar
  * FindPage: search or browse the wiki in various ways
  * TitleIndex: a list of all pages in the wiki
  * WordIndex: a list of all words that are part of the page titles
  * SandBox: feel free to change this page and experiment with editing

Here''s a title search.  Try something like ''''category'''':

<TitleSearch>

Here''s a full-text search.

<FullSearch>

You can also use regular expressions, such as

    {{{seriali[sz]e}}}

Or go to a page directly, or create a new page by entering its name here:
<GoTo>')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'RandomPages','1','1','1','3/17/2002 18:37:28','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','The following links are automatically generated, at random.

<RandomPage(10)>')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'WordIndex','1','1','1','3/17/2002 18:37:45','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<WordIndex>')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'WhatIsaWiki','1','1','1','3/17/2002 18:38:33','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','A Wiki is a collaboration tool - a web site where the pages can be changed and *INSTANTLY* published using only a web browser (no programming required). Pages are automatically created and linked to each other. 

  * Collaborate using modifiable web pages 
  * Automatic web page linking and creation 
  * Changes are *INSTANTLY* published
  * Increased information interchange

')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'FrontPage','1','0','1','3/17/2002 18:42:08','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','=== Welcome ===

Congratulations! OpenWiki appears to be working. :-)



----

Please report bugs at http://openwiki.com/?/Bugs
Please enter suggestions at http://openwiki.com/?/Suggestions

Or alternatively send them and any other comments you may have via email
to laurens@openwiki.com.

')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'FrontPage','2','0','1','3/17/2002 18:42:26','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','=== Welcome ===

Congratulations! OpenWiki appears to be working. :-)



----

Please report bugs at http://openwiki.com/?/Bugs

Please enter suggestions at http://openwiki.com/?/Suggestions

Or alternatively send them and any other comments you may have via email
to laurens@openwiki.com.

')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'OpenWiki','1','0','1','3/17/2002 18:43:06','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<SystemInfo>')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'OpenWiki','2','1','1','3/17/2002 18:44:04','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','This site is running the [http://openwiki.com OpenWiki] software.

<SystemInfo>')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'FrontPage','3','1','1','3/17/2002 18:45:24','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','=== Welcome ===

Congratulations! OpenWiki appears to be working. :-)



----

Please report installation issues at http://openwiki.com/?/Installation.

Please report bugs at http://openwiki.com/?/Bugs.

Please enter suggestions at http://openwiki.com/?/Suggestions.

Or alternatively send them and any other comments you may have via email
to laurens@openwiki.com.

')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'HelpOnEmoticons','1','1','1','3/17/2002 18:22:49','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','<Include(HelpMenu)>

''''''To use emoticons in text to show feelings''''''

You can type certain characters that are converted to graphic images, called emoticons. To insert an emoticon, just type in one from the list below. They''re only converted to an image if they are //followed by at least one whitespace//. In addition, the smileys must //begin with at least one whitespace//.

  :-)    {{{:-) or :)}}}
  ;-)    {{{;-) or ;)}}}
  :-D    {{{:-D or :D or :-d or :d}}}
  :-O    {{{:-O or :O or :-o or :o}}}
  :-P    {{{:-P or :-p}}}
  :-S    {{{:-S or :S or :-s or :s}}}
  :-|    {{{:-| or :|}}}
  :-(    {{{:-( or :(}}}
  (y)    {{{(Y) or (y)}}}  
  (n)    {{{(N) or (n)}}}  
  (L)    {{{(L) or (l)}}}  
  (u)    {{{(u) or (u)}}}  
  (k)    {{{(K) or (k)}}}  
  (g)    {{{(G) or (g)}}}  
  (f)    {{{(F) or (f)}}}  
  (p)    {{{(P) or (p)}}}  
  (b)    {{{(B) or (b)}}}  
  (d)    {{{(D) or (d)}}}
  (t)    {{{(T) or (t)}}}
  (@)    {{{(@)}}}
  (c)    {{{(C) or (c)}}}
  (i)    {{{(I) or (i)}}}
  (h)    {{{(H) or (h)}}}
  (s)    {{{(S) or (s)}}}
  (*)    {{{(*)}}}
  (8)    {{{(8)}}}
  (e)    {{{(E) or (e)}}}
  (m)    {{{(M) or (m)}}}
  /i\    {{{/i\ or /I\}}}
  /w\    {{{/w\ or /W\}}}
  /s\    {{{/s\ or /S\}}}

''''''Note''''''
<br/>
To turn off the ability to show emoticons you can go to your UserPreferences, click ''''''Show Emoticons'''''' to clear the check mark and then save your preferences.

----
CategoryHelp')ø
set term ;ø

set term ø;
insert into openwiki_revisions (wrv_name,wrv_revision, wrv_current, wrv_status, wrv_timestamp, wrv_minoredit, wrv_host, wrv_agent, wrv_by, wrv_byalias, wrv_comment, wrv_text) values (
'InterWiki','1','1','1','3/19/2002 1:07:56','0','127.0.0.1','Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.0.3705)','127.0.0.1','','','An InterWiki is another website you can create a link to by doing e.g.: Meatball:InterWiki or [Dictionary:antonyms What are antonyms?].

----

<InterWiki>')ø
set term ;ø
commit work;