#
# Table structure for table `cdr`
#

CREATE TABLE `cdr` (   
`id` int(9) unsigned NOT NULL auto_increment,   
`calldate` datetime NOT NULL default '1900-01-01 12:00:00',   
`clid` varchar(80) NOT NULL default '',   
`src` varchar(80) NOT NULL default '',   
`dst` varchar(80) NOT NULL default '',   
`dcontext` varchar(80) NOT NULL default '',   
`channel` varchar(80) NOT NULL default '',   
`dstchannel` varchar(80) NOT NULL default '',   
`lastapp` varchar(80) NOT NULL default '',   
`lastdata` varchar(80) NOT NULL default '',   
`duration` int(11) NOT NULL default '0',   
`billsec` int(11) NOT NULL default '0',   
`disposition` varchar(45) NOT NULL default '',   
`amaflags` int(11) NOT NULL default '0',   
`accountcode` varchar(20) NOT NULL default '',   
`uniqueid` varchar(32) NOT NULL default '',   
`userfield` varchar(255) NOT NULL default '',   
`filename` varchar(120) NOT NULL default 'none',
PRIMARY KEY  (`id`),   
KEY `calldate` (`calldate`),   
KEY `accountcode` (`accountcode`),   
KEY `uniqueid` (`uniqueid`),   
KEY `dst` (`dst`),   
KEY `src` (`src`) ) 
ENGINE=InnoDB AUTO_INCREMENT=1;
#
# Table structure for table `iaxfriends`
#

CREATE TABLE `iaxfriends` (
  `name` varchar(40) NOT NULL default '',
  `type` varchar(10) NOT NULL default 'friend', -- friend/user/peer
  `username` varchar(40) NULL, -- username to send as peer
  `mailbox` varchar(40) NULL, -- mailbox@context
  `secret` varchar(40) NULL,
  `dbsecret` varchar(40) NULL, -- In AstDB, location to store/retrieve secret
  `context` varchar(40) NULL,
  `regcontext` varchar(40) NULL,
  `host` varchar(40) NULL default 'dynamic',
  `ipaddr` varchar(40) NULL, -- Must be updateable by Asterisk user
  `port` int(5) NULL, -- Must be updateable by Asterisk user
  `defaultip` varchar(20) NULL,
  `sourceaddress` varchar(20) NULL,
  `mask` varchar(20) NULL,
  `regexten` varchar(40) NULL,
  `regseconds` int(11) NULL, -- Must be updateable by Asterisk user
  `accountcode` varchar(20) NULL, 
  `mohinterpret` varchar(20) NULL, 
  `mohsuggest` varchar(20) NULL, 
  `inkeys` varchar(40) NULL, 
  `outkey` varchar(40) NULL, 
  `language` varchar(10) NULL, 
  `callerid` varchar(100) NULL, -- The whole callerid string, or broken down in the next 3 fields
  `cid_number` varchar(40) NULL, -- The number portion of the callerid
  `sendani` varchar(10) NULL, -- yes/no
  `fullname` varchar(40) NULL, -- The name portion of the callerid
  `trunk` varchar(3) NULL, -- Yes/no
  `auth` varchar(20) NULL, -- RSA/md5/plaintext
  `maxauthreq` varchar(5) NULL, -- Maximum outstanding AUTHREQ calls {1-32767}
  `requirecalltoken` varchar(4) NULL, -- yes/no/auto
  `encryption` varchar(20) NULL, -- aes128/yes/no
  `transfer` varchar(10) NULL, -- mediaonly/yes/no
  `jitterbuffer` varchar(3) NULL, -- yes/no
  `forcejitterbuffer` varchar(3) NULL, -- yes/no
  `disallow` varchar(40) NULL, -- all/{list-of-codecs}
  `allow` varchar(40) NULL, -- all/{list-of-codecs}
  `codecpriority` varchar(40) NULL, 
  `qualify` varchar(10) NULL, -- yes/no/{number of milliseconds}
  `qualifysmoothing` varchar(10) NULL, -- yes/no
  `qualifyfreqok` varchar(10) NULL, -- {number of milliseconds}|60000
  `qualifyfreqnotok` varchar(10) NULL, -- {number of milliseconds}|10000
  `timezone` varchar(20) NULL, 
  `adsi` varchar(10) NULL, -- yes/no
  `amaflags` varchar(20) NULL, 
  `setvar` varchar(200) NULL, 
  PRIMARY KEY  (`name`),
  INDEX name (name, host),
  INDEX name2 (name, ipaddr, port),
  INDEX ipaddr (ipaddr, port),
  INDEX host (host, port)
)
ENGINE=InnoDB AUTO_INCREMENT=1;
-- 
-- Table structure for Realtime meetme
-- 

CREATE TABLE meetme (
	bookid int(11) auto_increment,
	confno char(80) DEFAULT '0' NOT NULL,
	starttime datetime default '1900-01-01 12:00:00',
	endtime datetime default '2038-01-01 12:00:00',
	pin char(20) NULL,
	adminpin char(20) NULL,
	opts char(20) NULL,
	adminopts char(20) NULL,
	recordingfilename char(80) NULL,
	recordingformat char(10) NULL,
	maxusers int(11) NULL,
	members integer DEFAULT 0 NOT NULL,
	index confno (confno,starttime,endtime),
	PRIMARY KEY (bookid)
)
ENGINE=InnoDB AUTO_INCREMENT=1;

CREATE TABLE musiconhold (
	-- Name of the MOH class
	name char(80) not null primary key,
	-- One of 'custom', 'files', 'mp3nb', 'quietmp3nb', or 'quietmp3'
	mode char(80) null,
	-- If 'custom', directory is ignored.  Otherwise, specifies a directory with files to play or a stream URL
	directory char(255) null,
	-- If 'custom', application will be invoked to provide MOH.  Ignored otherwise.
	application char(255) null,
	-- Digit associated with this MOH class, when MOH is selectable by the caller.
	digit char(1) null,
	-- One of 'random' or 'alpha', to determine how files are played.  If NULL, files are played in directory order
	sort char(10) null,
	-- In custom mode, the format of the audio delivered.  Ignored otherwise.  Defaults to SLIN.
	format char(10) null,
	-- When this record was last modified
	stamp timestamp
)
ENGINE=InnoDB AUTO_INCREMENT=1;

CREATE TABLE queue_log (
	-- Event date and time
	time datetime,
	-- "REALTIME", "NONE", or channel uniqueid
	callid char(50),
	-- Name of the queue affected
	queuename char(50),
	-- Interface name of the queue member
	agent char(50),
	-- One of ADDMEMBER, REMOVEMEMBER, RINGNOANSWER, EXITEMPTY, TRANSFER,
	-- AGENTDUMP, ABANDON, SYSCOMPAT, CONNECT, COMPLETECALLER, COMPLETEAGENT,
	-- PAUSEALL, UNPAUSEALL, PAUSE, UNPAUSE, PENALTY, ENTERQUEUE,
	-- EXITWITHTIMEOUT, EXITEMPTY, EXITWITHKEY, or another defined by the user.
	event char(20),
	-- data1 through data5 are possible arguments to the event, the definitions
	-- of which are dependent upon the type of event.
	data1 char(50),
	data2 char(50),
	data3 char(50),
	data4 char(50),
	data5 char(50),
	index bydate (time),
	index qname (queuename,time)
)
ENGINE=InnoDB AUTO_INCREMENT=1;
#
# Table structure for table `sippeers`
#

CREATE TABLE IF NOT EXISTS `sippeers` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `name` varchar(10) NOT NULL,
      `ipaddr` varchar(45) DEFAULT NULL,
      `port` int(5) DEFAULT NULL,
      `regseconds` int(11) DEFAULT NULL,
      `defaultuser` varchar(10) DEFAULT NULL,
      `fullcontact` varchar(80) DEFAULT NULL,
      `regserver` varchar(20) DEFAULT NULL,
      `useragent` varchar(20) DEFAULT NULL,
      `lastms` int(11) DEFAULT NULL,
      `host` varchar(40) DEFAULT NULL,
      `type` enum('friend','user','peer') DEFAULT NULL,
      `context` varchar(40) DEFAULT NULL,
      `permit` varchar(95) DEFAULT NULL,
      `deny` varchar(95) DEFAULT NULL,
      `secret` varchar(40) DEFAULT NULL,
      `md5secret` varchar(40) DEFAULT NULL,
      `remotesecret` varchar(40) DEFAULT NULL,
      `transport` enum('udp','tcp','udp,tcp','tcp,udp') DEFAULT NULL,
      `dtmfmode` enum('rfc2833','info','shortinfo','inband','auto') DEFAULT NULL,
      `directmedia` enum('yes','no','nonat','update') DEFAULT NULL,
      `nat` varchar(29) DEFAULT NULL, 
      `callgroup` varchar(40) DEFAULT NULL,
      `pickupgroup` varchar(40) DEFAULT NULL,
      `language` varchar(40) DEFAULT NULL,
      `disallow` varchar(40) DEFAULT NULL,
      `allow` varchar(40) DEFAULT NULL,
      `insecure` varchar(40) DEFAULT NULL,
      `trustrpid` enum('yes','no') DEFAULT NULL,
      `progressinband` enum('yes','no','never') DEFAULT NULL,
      `promiscredir` enum('yes','no') DEFAULT NULL,
      `useclientcode` enum('yes','no') DEFAULT NULL,
      `accountcode` varchar(40) DEFAULT NULL,
      `setvar` varchar(40) DEFAULT NULL,
      `callerid` varchar(40) DEFAULT NULL,
      `amaflags` varchar(40) DEFAULT NULL,
      `callcounter` enum('yes','no') DEFAULT NULL,
      `busylevel` int(11) DEFAULT NULL,
      `allowoverlap` enum('yes','no') DEFAULT NULL,
      `allowsubscribe` enum('yes','no') DEFAULT NULL,
      `videosupport` enum('yes','no') DEFAULT NULL,
      `maxcallbitrate` int(11) DEFAULT NULL,
      `rfc2833compensate` enum('yes','no') DEFAULT NULL,
      `mailbox` varchar(40) DEFAULT NULL,
      `session-timers` enum('accept','refuse','originate') DEFAULT NULL,
      `session-expires` int(11) DEFAULT NULL,
      `session-minse` int(11) DEFAULT NULL,
      `session-refresher` enum('uac','uas') DEFAULT NULL,
      `t38pt_usertpsource` varchar(40) DEFAULT NULL,
      `regexten` varchar(40) DEFAULT NULL,
      `fromdomain` varchar(40) DEFAULT NULL,
      `fromuser` varchar(40) DEFAULT NULL,
      `qualify` varchar(40) DEFAULT NULL,
      `defaultip` varchar(45) DEFAULT NULL,
      `rtptimeout` int(11) DEFAULT NULL,
      `rtpholdtimeout` int(11) DEFAULT NULL,
      `sendrpid` enum('yes','no') DEFAULT NULL,
      `outboundproxy` varchar(40) DEFAULT NULL,
      `callbackextension` varchar(40) DEFAULT NULL,
      `timert1` int(11) DEFAULT NULL,
      `timerb` int(11) DEFAULT NULL,
      `qualifyfreq` int(11) DEFAULT NULL,
      `constantssrc` enum('yes','no') DEFAULT NULL,
      `contactpermit` varchar(95) DEFAULT NULL,
      `contactdeny` varchar(95) DEFAULT NULL,
      `usereqphone` enum('yes','no') DEFAULT NULL,
      `textsupport` enum('yes','no') DEFAULT NULL,
      `faxdetect` enum('yes','no') DEFAULT NULL,
      `buggymwi` enum('yes','no') DEFAULT NULL,
      `auth` varchar(40) DEFAULT NULL,
      `fullname` varchar(40) DEFAULT NULL,
      `trunkname` varchar(40) DEFAULT NULL,
      `cid_number` varchar(40) DEFAULT NULL,
      `callingpres` enum('allowed_not_screened','allowed_passed_screen','allowed_failed_screen','allowed','prohib_not_screened','prohib_passed_screen','prohib_failed_screen','prohib') DEFAULT NULL,
      `mohinterpret` varchar(40) DEFAULT NULL,
      `mohsuggest` varchar(40) DEFAULT NULL,
      `parkinglot` varchar(40) DEFAULT NULL,
      `hasvoicemail` enum('yes','no') DEFAULT NULL,
      `subscribemwi` enum('yes','no') DEFAULT NULL,
      `vmexten` varchar(40) DEFAULT NULL,
      `autoframing` enum('yes','no') DEFAULT NULL,
      `rtpkeepalive` int(11) DEFAULT NULL,
      `call-limit` int(11) DEFAULT NULL,
      `g726nonstandard` enum('yes','no') DEFAULT NULL,
      `ignoresdpversion` enum('yes','no') DEFAULT NULL,
      `allowtransfer` enum('yes','no') DEFAULT NULL,
      `dynamic` enum('yes','no') DEFAULT NULL,
      PRIMARY KEY (`id`),
      UNIQUE KEY `name` (`name`),
      KEY `ipaddr` (`ipaddr`,`port`),
      KEY `host` (`host`,`port`)
)
ENGINE=InnoDB AUTO_INCREMENT=1;

DROP TABLE IF EXISTS voicemail_data;
CREATE TABLE voicemail_data (
	-- Path to the recording
	filename CHAR(255) NOT NULL PRIMARY KEY,
	-- Mailbox number (without context)
	origmailbox CHAR(80),
	-- Dialplan context
	context CHAR(80),
	-- Dialplan context, if voicemail was invoked from a macro
	macrocontext CHAR(80),
	-- Dialplan extension
	exten CHAR(80),
	-- Dialplan priority
	priority INT(5),
	-- Name of the channel, when message was left
	callerchan CHAR(80),
	-- CallerID on the channel, when message was left
	callerid CHAR(80),
	-- Contrary to the name, origdate is a full datetime, in localized format
	origdate CHAR(30),
	-- Same date as origdate, but in Unixtime
	origtime INT(11),
	-- Value of the channel variable VM_CATEGORY, if set
	category CHAR(30),
	-- Length of the message, in seconds
	duration INT(11)
)
ENGINE=InnoDB AUTO_INCREMENT=1;

-- While this does not use the realtime backend, for brevity, we include this table here, as well.
DROP TABLE IF EXISTS voicemail_messages;
CREATE TABLE voicemail_messages (
	-- Logical directory
	dir CHAR(255),
	-- Message number within the logical directory
	msgnum INT(4),
	-- Dialplan context
	context CHAR(80),
	-- Dialplan context, if Voicemail was invoked from a macro
	macrocontext CHAR(80),
	-- CallerID, when the message was left
	callerid CHAR(80),
	-- Date when the message was left, in Unixtime
	origtime INT(11),
	-- Length of the message, in seconds
	duration INT(11),
	-- The recording itself
	recording BLOB,
	-- Text flags indicating urgency of the message
	flag CHAR(30),
	-- Value of channel variable VM_CATEGORY, if set
	category CHAR(30),
	-- Owner of the mailbox
	mailboxuser CHAR(30),
	-- Context of the owner of the mailbox
	mailboxcontext CHAR(30),
	PRIMARY KEY (dir, msgnum)
)
ENGINE=InnoDB AUTO_INCREMENT=1;

DROP TABLE IF EXISTS voicemail;
CREATE TABLE voicemail (
	-- All of these column names are very specific, including "uniqueid".  Do not change them if you wish voicemail to work.
	uniqueid INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	-- Mailbox context.
	context CHAR(80) NOT NULL DEFAULT 'default',
	-- Mailbox number.  Should be numeric.
	mailbox CHAR(80) NOT NULL,
	-- Must be numeric.  Negative if you don't want it to be changed from VoicemailMain
	password CHAR(80) NOT NULL,
	-- Used in email and for Directory app
	fullname CHAR(80),
	-- Email address (will get sound file if attach=yes)
	email CHAR(80),
	-- Email address (won't get sound file)
	pager CHAR(80),
	-- Attach sound file to email - YES/no
	attach CHAR(3),
	-- Which sound format to attach
	attachfmt CHAR(10),
	-- Send email from this address
	serveremail CHAR(80),
	-- Prompts in alternative language
	language CHAR(20),
	-- Alternative timezone, as defined in voicemail.conf
	tz CHAR(30),
	-- Delete voicemail from server after sending email notification - yes/NO
	deletevoicemail CHAR(3),
	-- Read back CallerID information during playback - yes/NO
	saycid CHAR(3),
	-- Allow user to send voicemail from within VoicemailMain - YES/no
	sendvoicemail CHAR(3),
	-- Listen to voicemail and approve before sending - yes/NO
	review CHAR(3),
	-- Warn user a temporary greeting exists - yes/NO
	tempgreetwarn CHAR(3),
	-- Allow '0' to jump out during greeting - yes/NO
	operator CHAR(3),
	-- Hear date/time of message within VoicemailMain - YES/no
	envelope CHAR(3),
	-- Hear length of message within VoicemailMain - yes/NO
	sayduration CHAR(3),
	-- Minimum duration in minutes to say
	saydurationm INT(3),
	-- Force new user to record name when entering voicemail - yes/NO
	forcename CHAR(3),
	-- Force new user to record greetings when entering voicemail - yes/NO
	forcegreetings CHAR(3),
	-- Context in which to dial extension for callback
	callback CHAR(80),
	-- Context in which to dial extension (from advanced menu)
	dialout CHAR(80),
	-- Context in which to execute 0 or * escape during greeting
	exitcontext CHAR(80),
	-- Maximum messages in a folder (100 if not specified)
	maxmsg INT(5),
	-- Increase DB gain on recorded message by this amount (0.0 means none)
	volgain DECIMAL(5,2),
	-- IMAP user for authentication (if using IMAP storage)
	imapuser VARCHAR(80),
	-- IMAP password for authentication (if using IMAP storage)
	imappassword VARCHAR(80),
	stamp timestamp
)
ENGINE=InnoDB AUTO_INCREMENT=1;
